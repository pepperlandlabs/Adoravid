/* Copyright (C) 2012 IGN Entertainment, Inc. */
/*
#import "VideoPlayerSampleView.h"

@interface VideoPlayerSampleView()

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *videoPlayerView;
@property (nonatomic, readwrite, strong) UIButton *playButton;

@end

@implementation VideoPlayerSampleView

- (id)initWithTopView:(UIView *)topView videoPlayerView:(UIView *)videoPlayerView
{
    if ((self = [super init])) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialScreen"];
        //self.playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[self.playButton setTitle:@"Play Video" forState:UIControlStateNormal];
        //[self addSubview:self.playButton];
        //self.backgroundColor = [UIColor whiteColor];
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cutepup.jpg"]];
       
        /*UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"cutepup.jpg"] drawInRect:self.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.backgroundColor = [UIColor colorWithPatternImage:image];
        */
        
        /*UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:videoPlayerView.frame];
        [backgroundImage setImage:[UIImage imageNamed:@"cutepup.jpg"]];
        
        // choose best mode that works for you
        [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
        
        [self insertSubview:backgroundImage atIndex:0];
    }
    
    return self;
}

/*
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.playButton.frame = CGRectMake((bounds.size.width - 100)/2.0,
                                       (bounds.size.height - 50)/2.0,
                                       100,
                                       50);
    
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
*/