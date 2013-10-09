//
//  MovieViewController.h
//  Vidyaww
//
//  Created by Tyson White on 9/29/13.
//  Copyright (c) 2013 Tyson White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerKit.h"

@interface MovieViewController : UIViewController
@property (strong, nonatomic) NSURL *currentURL;
@property (strong,nonatomic) NSURL *getvidURL;
@property (strong, nonatomic) NSArray *videoArray;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
- (IBAction)playVideo:(id)sender;

//@property (nonatomic, readonly, strong) UIButton *playButton;


@property (nonatomic) BOOL fullScreenToggled;

@property NSURL *address;


@end

@interface VideoPlayerSampleView : UIView
- (id)initWithTopView:(UIView *)topView videoPlayerView:(UIView *)videoPlayerView;
@end