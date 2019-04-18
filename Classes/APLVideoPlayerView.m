//
//  APLVideoPlayerView.m
//  APLVideoPlayerView
//
//  Created by apploft on 03.05.18.
//  Copyright © 2018 apploft GmbH. All rights reserved.
//

#import "APLVideoPlayerView.h"

@interface APLVideoPlayerView()
@property (nonatomic, copy) NSString *videoFilename;
@property (nonatomic, weak) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, strong) AVPlayerLooper *avPlayerLooper;
@end

@implementation APLVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    self.videoGravity = AVLayerVideoGravityResizeAspectFill;

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    AVPlayerLayer *avPlayerLayer = [[AVPlayerLayer alloc] init];
    avPlayerLayer.videoGravity = self.videoGravity;
    
    avPlayerLayer.frame = self.bounds;
    [[self layer] addSublayer:avPlayerLayer];
    
    self.avPlayerLayer = avPlayerLayer;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.avPlayerLayer.frame = self.bounds;
}

-(void)setVideoFilename:(NSString *)videoFilename withExtension:(NSString *)extension loop:(BOOL)loop {
    if ([_videoFilename isEqualToString:videoFilename]) {
        return;
    }

    _videoFilename = videoFilename;
    
    NSURL *videoFileURL = [[NSBundle mainBundle] URLForResource:videoFilename withExtension:extension];
    
    NSAssert(videoFileURL != nil, @"Onboarding video missing in bundle");
    
    AVAsset *videoAsset = [AVAsset assetWithURL:videoFileURL];
    AVPlayerItem *avPlayerItem = [AVPlayerItem playerItemWithAsset:videoAsset];
    AVQueuePlayer *queuePlayer = [[AVQueuePlayer alloc] initWithItems:@[avPlayerItem]];
    if (loop) {
        AVPlayerLooper *playerLooper = [AVPlayerLooper playerLooperWithPlayer:queuePlayer templateItem:avPlayerItem];
        self.avPlayerLooper = playerLooper;
    }
    
    self.avPlayer = queuePlayer;
    
    self.avPlayerLayer.player = self.avPlayer;
}

-(void)setVideoGravity:(AVLayerVideoGravity)videoGravity {
    _videoGravity = videoGravity;
    // set video gravity in avPlayerLayer if already existing
    self.avPlayerLayer.videoGravity = videoGravity;
}

-(void)play {
    [self.avPlayer play];
}

-(void)pause {
    [self.avPlayer pause];
}

-(void)configureForAmbientPlayback {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    [audioSession setActive:YES error:nil];
    self.avPlayer.allowsExternalPlayback = NO;
}

#pragma mark - Background Handling

/*
 * One gotcha with the AVPlayer is that it pauses its ouput
 * when the app is sent to background. See
 * https://developer.apple.com/library/archive/qa/qa1668/_index.html
 * for reference. The recommendation is to remove the the layer's player
 * on -applicationDidEnterBackground: and to re-assign it
 * on -applicationDidBecomeActive:. That's what we've already done in
 * HBMB.
 */

-(void)applicationDidEnterBackground:(NSNotification *)notification {
    self.avPlayerLayer.player = nil;
}

-(void)applicationDidBecomeActive:(NSNotification *)notification {
    self.avPlayerLayer.player = self.avPlayer;
}

@end
