//
//  AssetCellViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/17.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetCellViewController.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - AssetCellView

@implementation AssetCellView

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [_imageView release];
    [super dealloc];
}

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - AssetCellViewController


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
