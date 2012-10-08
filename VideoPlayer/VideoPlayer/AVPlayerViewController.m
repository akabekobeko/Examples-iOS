//
//  AVPlayerViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AVPlayerViewController.h"

@interface AVPlayerViewController ()

@property (nonatomic, retain) NSURL* videoUrl; //! 動画の URL

@end

@implementation AVPlayerViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @param videoUrl 動画の URL。
 *
 * @return インスタンス。
 */
+ (AVPlayerViewController *)controller:(NSURL *)videoUrl
{
    AVPlayerViewController* controller = [[[AVPlayerViewController alloc] initWithNibName:@"AVPlayerViewController" bundle:nil] autorelease];
    controller.videoUrl = videoUrl;

    return controller;
}

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"AVPlayer";
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end
