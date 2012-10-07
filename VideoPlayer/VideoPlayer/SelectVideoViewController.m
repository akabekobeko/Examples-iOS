//
//  SelectVideoViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/07.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "SelectVideoViewController.h"

@interface SelectVideoViewController () <ABGridViewDelegate>

@property (nonatomic, assign) id<SelectVideoViewControllerDelegate> delegate; //! デリゲート

@end

@implementation SelectVideoViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @param delegate デリゲート。
 *
 * @return インスタンス。
 */
+ (SelectVideoViewController *)controller:(id<SelectVideoViewControllerDelegate>)delegate
{
    SelectVideoViewController* contrller = [[[SelectVideoViewController alloc] initWithNibName:@"SelectVideoViewController" bundle:nil] autorelease];
    contrller.delegate = delegate;
 
    return contrller;
}

/**
 * インスタンスを破棄します。
 */

- (void)dealloc
{
    self.delegate = nil;
    self.gridView = nil;

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    self.delegate = nil;
    self.gridView = nil;

    [super viewDidUnload];
}

#pragma mark - ABGridViewDelegate

@end
