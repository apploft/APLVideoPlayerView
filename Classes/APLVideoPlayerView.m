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
    
    AVPlayerLayer *avPlayerLayer = [[AVPlayerLayer alloc] init];
    avPlayerLayer.videoGravity = self.videoGravity;
    
    avPlayerLayer.frame = self.bounds;
    [[self layer] addSublayer:avPlayerLayer];
    
    self.avPlayerLayer = avPlayerLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.avPlayerLayer.frame = self.bounds;
}

-(void)setVideoFilename:(NSString *)videoFilename loop:(Boolean) loop {
    if ([_videoFilename isEqualToString:videoFilename]) {
        return;
    }
    
    _videoFilename = videoFilename;
    
    NSURL *videoFileURL = [[NSBundle mainBundle] URLForResource:videoFilename withExtension:@"mp4"];
    
    AVAsset *videoAsset = [AVAsset assetWithURL:videoFileURL];
    AVPlayerItem *avPlayerItem = [AVPlayerItem playerItemWithAsset:videoAsset];
    AVQueuePlayer *queuePlayer = [[AVQueuePlayer alloc] initWithItems:@[avPlayerItem]];
    if (loop) {
        AVPlayerLooper *playerLooper = [AVPlayerLooper playerLooperWithPlayer:queuePlayer templateItem:avPlayerItem];
        self.avPlayerLooper = playerLooper;
    }
    
    NSAssert(videoFileURL != nil, @"Onboarding video missing in bundle");
    
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

@end
