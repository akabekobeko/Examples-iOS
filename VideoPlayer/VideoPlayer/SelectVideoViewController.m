//
//  SelectVideoViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/07.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "SelectVideoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SelectVideoViewController () <ABGridViewDelegate>

@property (nonatomic, assign) id<SelectVideoViewControllerDelegate> delegate;      //! デリゲート
@property (nonatomic, retain) ALAssetsLibrary*                      assetsLibrary; //! アセット情報ライブラリ
@property (nonatomic, retain) NSMutableArray*                       assets;        //! アセット情報のコレクション

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
    self.assets   = nil;

    [super viewDidUnload];
}

#pragma mark - ABGridViewDelegate

#pragma mark - Grid view delegate

/**
 * グリッド配置するアイテムの総数を取得します。
 *
 * @param gridView グリッド配置コンテナ。
 *
 * @return アイテムの総数。
 */
- (NSInteger)numberOfItemsInGridView:(ABGridView *)gridView
{
    return self.assets.count;
}

/**
 * 指定されたインデックスのアイテムを取得します。
 *
 * @param gridView グリッド配置コンテナ。
 * @param index    インデックス。
 *
 * @return アイテム。
 */
- (UIView *)viewForItemInGridView:(ABGridView *)gridView atIndex:(NSInteger)index
{
    return nil;
}

/**
 * アイテムが選択された時に発生します。
 *
 * @param gridView グリッド配置コンテナ。
 * @param view     アイテム。
 */
- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
}

#pragma mark - Private

@end
