//
//  ViewController.m
//  Vidyaww
//
//  Created by Tyson White on 9/29/13.
//  Copyright (c) 2013 Tyson White. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kVideoFromJsonURL [NSURL URLWithString:@"http://pepperlandlabs.com/couch/couch2.json"]

#import "MovieViewController.h"
#import "NSArray+Random.h"

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

@implementation MovieViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kVideoFromJsonURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

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
    
    // 1) Get a random video
    //NSInteger randomIndex = arc4random()%6;
    //NSDictionary* video = [latestVideos objectAtIndex:randomIndex];
    //NSDictionary* video = [self.videoArray randomObject];
    // 2) Get the video URL
    //NSString* videoTitle = [video objectForKey:@"title"];
    //NSString* videoURL = [video objectForKey:@"video_url"];
    //self.currentURL = [NSURL URLWithString:[video objectForKey:@"video_url"]];
    // 3) Set the label appropriately
    // humanReadble.text = [NSString stringWithFormat:@"Latest video: %@",
    //                     videoURL];
}

- (void)playMovie:(id)sender
{
    //NSURL *url = [NSURL URLWithString:
      //            @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    NSDictionary* video = [self.videoArray randomObject];
    self.currentURL = [NSURL URLWithString:[video objectForKey:@"video_url"]];
    
    NSURL *url = self.currentURL;
    
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MPMoviePlayerDidExitFullscreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:_moviePlayer];*/
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
        //[NSDictionary* video = [self.videoArray randomObject]
        // self.currentURL = [NSURL URLWithString:[video objectForKey:@"video_url"];
        
    }
}
/*
- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerDidExitFullscreenNotification
     object:player];
    
    [player.view removeFromSuperview];
    [self.view setNeedsDisplay];
}
*/

@end