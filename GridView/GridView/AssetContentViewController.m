//
//  AssetContentViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetContentViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetContentViewController () <ABGridViewDelegate>

@property (nonatomic, retain) ALAssetsLibrary* assetLibrary; //! AssetsLibrary
@property (nonatomic, retain) NSMutableArray*  assets;       //! AssetsLibrary 内のコンテンツ情報コレクション

@end

@implementation AssetContentViewController

#pragma mark - Lifecycle

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
	[_assetGridView release];
	[super dealloc];
}

#pragma mark - View controller

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
	[self setAssetGridView:nil];

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

#pragma mark - Grid view delegate

/**
 * グリッド配置するアイテムの総数を取得します。
 *
 * @apram gridView グリッド配置コンテナ。
 *
 * @return アイテムの総数。
 */
- (NSInteger)numberOfItemsInGridView:(ABGridView *)gridView
{
	return 0;
}

/**
 * 指定されたインデックスのアイテムを取得します。
 *
 * @apram gridView グリッド配置コンテナ。
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
 * @apram gridView グリッド配置コンテナ。
 * @apram view     アイテム。
 */
- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
}

@end
