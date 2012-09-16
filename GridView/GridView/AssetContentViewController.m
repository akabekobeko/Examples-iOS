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
    [_assets        release];
    [_group         release];
    
    [super dealloc];
}

#pragma mark - View controller

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title  = ( self.isViewModeUIImage ? @"UIImageView" : @"Original Cell" );
    self.assets = [[[NSMutableArray alloc] initWithCapacity:self.group.numberOfAssets] autorelease];

    self.assetGridView.delegate = self;

    [self performSelectorInBackground:@selector(loadAssets) withObject:nil];
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
    [self setAssetGridView:nil];
    [self setGroup:nil];
    [self setAssets:nil];

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
    return ( self.isViewModeUIImage ?
            [self viewForItemInGridViewAtImageView:gridView atIndex:index] :
            [self viewForItemInGridViewAtOriginalCell:gridView atIndex:index] );
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

/**
 * 指定されたインデックスのアイテムを UIImageView として取得します。
 *
 * @param gridView グリッド配置コンテナ。
 * @param index    インデックス。
 *
 * @return アイテム。
 */
- (UIView *)viewForItemInGridViewAtImageView:(ABGridView *)gridView atIndex:(NSInteger)index
{
    UIImageView* item = ( UIImageView* )[gridView dequeueReusableItem];
    if( item == nil )
    {
        item = [[[UIImageView alloc] init] autorelease];
    }
 
    ALAsset* asset = [self.assets objectAtIndex:index];
    item.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
    return item;
}

/**
 * 指定されたインデックスのアイテムを独自セルとして取得します。
 *
 * @param gridView グリッド配置コンテナ。
 * @param index    インデックス。
 *
 * @return アイテム。
 */
- (UIView *)viewForItemInGridViewAtOriginalCell:(ABGridView *)gridView atIndex:(NSInteger)index
{
    return nil;
}

/**
 * アセットを読み込みます。
 */
- (void)loadAssets
{
    [self.group enumerateAssetsUsingBlock:^( ALAsset *result, NSUInteger index, BOOL *stop )
    {
        if( result == nil ) { return; }

        [self.assets addObject:result];
        [self performSelectorOnMainThread:@selector(reloadAssetGrid) withObject:nil waitUntilDone:NO];
    }];
}

/**
 * グリッド配置コンテナを再読み込みします。
 */
- (void)reloadAssetGrid
{
    [self.assetGridView reloadData];
}

@end
