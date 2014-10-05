//
//  MoviePlayerViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerViewController ()

@property (nonatomic, retain) MPMoviePlayerController* videoPlayer; //! 動画プレイヤー
@property (nonatomic, retain) NSURL*                   videoUrl;    //! 動画の URL

@end

@implementation MoviePlayerViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @param videoUrl 動画の URL。
 *
 * @return インスタンス。
 */
+ (MoviePlayerViewController *)controller:(NSURL *)videoUrl
{
    MoviePlayerViewController* controller = [[MoviePlayerViewController alloc] initWithNibName:@"MoviePlayerViewController" bundle:nil];
    controller.videoUrl = videoUrl;

    return controller;
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MPMoviePlayerController";

    self.videoPlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.videoUrl];
    self.videoPlayer.controlStyle             = MPMovieControlStyleDefault;
    self.videoPlayer.scalingMode              = MPMovieScalingModeAspectFit;
    self.videoPlayer.shouldAutoplay           = NO;
	self.videoPlayer.view.autoresizingMask    = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.videoPlayer.view.autoresizesSubviews = YES;
    self.videoPlayer.view.frame               = self.view.bounds;
    
    [self.videoPlayer prepareToPlay];
    [self.view addSubview:self.videoPlayer.view];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [self.videoPlayer stop];

    self.videoPlayer = nil;
    self.videoUrl    = nil;

    [super viewDidUnload];
}

/**
 * 画面が表示される時に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setWantsFullScreenLayout:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.view setNeedsLayout];
}

/**
 * 他の画面へ切り替わる時に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [super viewWillDisappear:animated];
}

@end
