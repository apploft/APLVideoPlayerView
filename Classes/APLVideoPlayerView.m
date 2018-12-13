//
//  APLVideoPlayerView.m
//  APLVideoPlayerView
//
//  Created by apploft on 03.05.18.
//  Copyright © 2018 apploft GmbH. All rights reserved.
//

#import "APLVideoPlayerView.h"

#import <AVKit/AVKit.h>

@interface APLVideoPlayerView()
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, weak) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, strong) AVPlayerLooper *avPlayerLooper;
@end

@implementation APLVideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame videoFilename:(NSString*)videoFilename {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
        self.videoFilename = videoFilename;
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
    AVPlayerLayer *avPlayerLayer = [[AVPlayerLayer alloc] init];
    avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    avPlayerLayer.frame = self.bounds;
    [[self layer] addSublayer:avPlayerLayer];
    
    self.avPlayerLayer = avPlayerLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.avPlayerLayer.frame = self.bounds;
}

-(void)setVideoFilename:(NSString *)videoFilename {
    if ([_videoFilename isEqualToString:videoFilename]) {
        return;
    }
    
    _videoFilename = videoFilename;
    
    NSURL *videoFileURL = [[NSBundle mainBundle] URLForResource:videoFilename withExtension:@"mp4"];
    
    AVAsset *videoAsset = [AVAsset assetWithURL:videoFileURL];
    AVPlayerItem *avPlayerItem = [AVPlayerItem playerItemWithAsset:videoAsset];
    AVQueuePlayer *queuePlayer = [[AVQueuePlayer alloc] initWithItems:@[avPlayerItem]];
    AVPlayerLooper *playerLooper = [AVPlayerLooper playerLooperWithPlayer:queuePlayer templateItem:avPlayerItem];
    
    self.avPlayerLooper = playerLooper;
    
    NSAssert(videoFileURL != nil, @"Onboarding video missing in bundle");
    
    self.avPlayer = queuePlayer;
    
    self.avPlayerLayer.player = self.avPlayer;
}

-(void)play {
    [self.avPlayer play];
}

-(void)pause {
    [self.avPlayer pause];
}

@end
