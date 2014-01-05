//
//  GoogleMapsViewController.m
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import "GoogleMapsViewController.h"

@interface GoogleMapsViewController () <UIWebViewDelegate>

@end

@implementation GoogleMapsViewController

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = LTEXT( @"Google Maps API" );
}

@end
