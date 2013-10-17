//
//  ViewController.m
//  Vidyaww
//
//  Created by Tyson White on 9/29/13.
//  Copyright (c) 2013 Tyson White. All rights reserved.
//
//#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//#define kVideoFromJsonURL [NSURL URLWithString:@"http://pepperlandlabs.com/couch/couch3.json"]

#import "MovieViewController.h"
//#import "VideoPlayerSampleView.h"
#import "NSArray+Random.h"
#import "HCYoutubeParser.h"
#import "Flurry.h"

@interface MovieViewController ()

@property (nonatomic, strong) VideoPlayerKit *videoPlayerViewController;
@property (nonatomic, strong) UIView *topView;
//@property (nonatomic, strong) VideoPlayerSampleView *videoPlayerSampleView;
@end

/*
@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
*/

@implementation MovieViewController

- (id)init
{
    if ((self = [super init])) {
        
        /*  // Optional Top View
         _topView = [[UIView alloc] init];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         button.frame = CGRectMake(0, 0, 200, 40.0);
         [button addTarget:self
         action:@selector(fullScreen)
         forControlEvents:UIControlEventTouchDown];
         
         [button setTitle:@"Full Screen!" forState:UIControlStateNormal];
         [_topView addSubview:button];*/
    }
    return self;
}

// Fullscreen / minimize without need for user's input
- (void)fullScreen
{
    if (!self.videoPlayerViewController.fullScreenModeToggled) {
        [self.videoPlayerViewController launchFullScreen];
    } else {
        [self.videoPlayerViewController minimizeVideo];
    }
}
/*
- (void)loadView
{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UIViewController *myMovieViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialScreen"];
    self.videoPlayerSampleView = [[VideoPlayerSampleView alloc] initWithTopView:nil videoPlayerView:nil];
    //[self.videoPlayerSampleView.playButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self setView:self.videoPlayerSampleView];
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.bounds.size.width, 44);
    
    /*dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kVideoFromJsonURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });*/
    [Flurry logEvent:@"Video_view_load"];
}

/*
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestVideos = [json objectForKey:@"videodata"]; //2
    self.videoArray = latestVideos;
    
    NSLog(@"videodata: %@", latestVideos); //3
}
 */

- (void)playVideo:(id)sender
{

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cute-api.herokuapp.com/get_random_video"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSDictionary *videoData = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    self.videoURL = [NSURL URLWithString:[videoData objectForKey:@"url"]];
    NSURL *yturl = self.videoURL;
    
    //NSDictionary* video = [self.videoArray randomObject];
    //self.getvidURL = [NSURL URLWithString:[video objectForKey:@"video_url"]];
    NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL: self.videoURL];
    self.currentURL = [NSURL URLWithString:[videos objectForKey:@"medium"]];
    
    //NSURL *yturl = self.getvidURL;
    NSURL *url = self.currentURL;
    
    NSLog(@"%@", yturl);
    
    if (!self.videoPlayerViewController) {
        self.videoPlayerViewController = [VideoPlayerKit videoPlayerWithContainingViewController:self optionalTopView:_topView hideTopViewWithControls:YES];
        // Need to set edge inset if top view is inserted
        [self.videoPlayerViewController setControlsEdgeInsets:UIEdgeInsetsMake(self.topView.frame.size.height, 0, 0, 0)];
        self.videoPlayerViewController.delegate = self;
        self.videoPlayerViewController.allowPortraitFullscreen = YES;
    }
    
    [self.view addSubview:self.videoPlayerViewController.view];
    
    [self.videoPlayerViewController playVideoWithTitle:@"Title" URL:url videoID:nil shareURL:yturl isStreaming:YES playInFullScreen:YES];
    [Flurry logEvent:@"Video_Played" withParameters:videoData timed:YES];
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
