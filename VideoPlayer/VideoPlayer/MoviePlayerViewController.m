//
//  MoviePlayerViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "MoviePlayerViewController.h"

@interface MoviePlayerViewController ()

@end

@implementation MoviePlayerViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (MoviePlayerViewController *)controller
{
    return [[[MoviePlayerViewController alloc] initWithNibName:@"MoviePlayerViewController" bundle:nil] autorelease];
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
    
    self.title = @"MPMoviePlayerController";
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end
