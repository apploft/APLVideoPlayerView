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
@property (nonatomic, copy) NSString *videoFilename;
/// A value that defines how the video is displayed within a layer’s bounds rectangle. Default mode is AVLayerVideoGravityResizeAspectFill.
@property (nonatomic) AVLayerVideoGravity videoGravity;

-(instancetype)initWithFrame:(CGRect)frame videoFilename:(NSString*)videoFilename;

-(void)play;
-(void)pause;
@end
