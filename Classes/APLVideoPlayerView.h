//
//  APLVideoPlayerView.h
//  APLVideoPlayerView
//
//  Created by apploft on 03.05.18.
//  Copyright © 2018 apploft GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APLVideoPlayerView : UIView
@property (nonatomic, copy) NSString *videoFilename;

-(instancetype)initWithFrame:(CGRect)frame videoFilename:(NSString*)videoFilename;

-(void)play;
-(void)pause;
@end
