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

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - ThumbnailCellViewController

@interface AssetCellViewController ()

@end

@implementation AssetCellViewController

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
    _cell = nil;

    [super viewDidUnload];
}

@end
