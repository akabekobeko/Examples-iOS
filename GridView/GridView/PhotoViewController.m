//
//  PhotoViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/17.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [_imageView release];
    [_image release];

    [super dealloc];
}

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title           = @"Photo";
    self.imageView.image = self.image;
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setImage:nil];

    [super viewDidUnload];
}

/**
 * 画面が表示される時に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setWantsFullScreenLayout:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

/**
 * 画面が非表示となる直前に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

/**
 * 画面が回転される時に発生します。
 *
 * @param interfaceOrientation 回転される向き。
 *
 * @return 回転可能なら YES。それ以外は NO。
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

@end
