//
//  ThumbnailCellViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/08.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetCellViewController.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - ThumbnailCellView

@implementation AssetCellView

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    self.imageView = nil;
    self.propertyView = nil;
    self.durationLabel = nil;

    [super dealloc];
}

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - ThumbnailCellViewController

@interface AssetCellViewController ()

@end

@implementation AssetCellViewController

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [_cell release];

    [super dealloc];
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
    [_cell release];
    _cell = nil;

    [super viewDidUnload];
}

@end
