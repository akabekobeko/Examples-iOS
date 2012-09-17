//
//  AssetContentViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetContentViewController.h"
#import "AssetCellViewController.h"
#import "PhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

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
    self.assetGridView.minimumColumnGap = 4;
    self.assetGridView.itemSize = self.isViewModeUIImage ? CGSizeMake(75, 75) : CGSizeMake(100, 100);

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
    const NSInteger index = ( self.isViewModeUIImage ? view.tag : ( ( AssetCellView* )view ).index );
    
    ALAsset* asset = [self.assets objectAtIndex:index];
    if( asset == nil ) { return; }
    
    ALAssetRepresentation* rep = [asset defaultRepresentation];
    UIImage* image  = [UIImage imageWithCGImage:[rep fullScreenImage] scale:[rep scale] orientation:( UIImageOrientation )[rep orientation]];

	// 戻るボタン
	UIBarButtonItem* back = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
	self.navigationItem.backBarButtonItem = back;

    PhotoViewController* controller = [[[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil] autorelease];
    controller.image = image;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private

/**
 * 指定された UIView に影を付けます。
 *
 * @param view ビュー。
 */
- (void)addViewShadow:(UIView*)view
{
	view.layer.shadowColor   = [UIColor blackColor].CGColor;
	view.layer.shadowOpacity = 0.9f;
	view.layer.shadowOffset  = CGSizeMake( 0.0f, 1.0f );
	view.layer.shadowRadius  = 1.0f;
}

/**
 * アセットを読み込みます。
 */
- (void)loadAssets
{
    [self.group enumerateAssetsUsingBlock:^( ALAsset *result, NSUInteger index, BOOL *stop )
    {
        if( result == nil ) { return; }

        // 写真のみ
        NSString* type = [result valueForProperty:ALAssetPropertyType];
        if( [type isEqualToString:ALAssetTypeVideo] ) { return; }
        
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
    AssetCellView* item = ( AssetCellView* )[gridView dequeueReusableItem];
    if( item == nil )
    {
        AssetCellViewController* controller = [[[AssetCellViewController alloc] initWithNibName:@"AssetCellViewController" bundle:nil] autorelease];
        item = ( AssetCellView* )controller.view;
        [self addViewShadow:item];
    }
    
    ALAsset* asset = [self.assets objectAtIndex:index];
    item.index           = index;
    item.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
    return item;
}

@end
