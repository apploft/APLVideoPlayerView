//
//  APLVideoPlayerView.h
//  APLVideoPlayerView
//
//  Created by apploft on 03.05.18.
//  Copyright © 2018 apploft GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface APLVideoPlayerView : UIView
@property (nonatomic, strong) AVPlayer *avPlayer;
/// A value that defines how the video is displayed within a layer’s bounds rectangle. Default mode is AVLayerVideoGravityResizeAspectFill.
@property (nonatomic) AVLayerVideoGravity videoGravity;

-(void)setVideoFilename:(NSString *)videoFilename withExtension:(NSString *)extension loop:(BOOL)loop;

/// When you do not want the user's audio playback (Apple Music, Spotify, ...) to stop, call this method. It disables AirPlay for this APLVideoPlayerView instance and sets the audio session to Ambient so that the user's current playback is not interrupted. Useful for video animations or launch screens.
-(void)configureForAmbientPlayback;

-(void)play;
-(void)pause;
@end
