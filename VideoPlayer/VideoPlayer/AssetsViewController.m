//
//  SelectVideoViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/07.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetsViewController.h"
#import "AssetCellViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetsViewController () <ABGridViewDelegate>

@property (nonatomic, assign) id<AssetsViewControllerDelegate> delegate;      //! デリゲート
@property (nonatomic, retain) ALAssetsLibrary*                 assetsLibrary; //! アセット情報ライブラリ
@property (nonatomic, retain) ALAssetsGroup*                   assetsGroup;   //! アセットのグループ情報
@property (nonatomic, retain) NSMutableArray*                  assets;        //! アセット情報のコレクション

@end

@implementation AssetsViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @param delegate デリゲート。
 *
 * @return インスタンス。
 */
+ (UIViewController *)controller:(id<AssetsViewControllerDelegate>)delegate
{
    AssetsViewController* contrller = [[[AssetsViewController alloc] initWithNibName:@"AssetsViewController" bundle:nil] autorelease];
    contrller.delegate = delegate;
    
    UINavigationController* navi = [[[UINavigationController alloc] initWithRootViewController:contrller] autorelease];
    navi.navigationBar.barStyle = UIBarStyleBlackOpaque;

    return navi;
}

/**
 * インスタンスを破棄します。
 */

- (void)dealloc
{
    self.delegate      = nil;
    self.gridView      = nil;
    self.assets        = nil;
    self.assetsGroup   = nil;
    self.assetsLibrary = nil;

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select Video";

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];

    self.gridView.delegate = self;
    self.gridView.itemSize = CGSizeMake( 100, 100 );
    self.assetsLibrary     = [[[ALAssetsLibrary alloc] init] autorelease];
    [self performSelectorInBackground:@selector(loadAssetsGroups) withObject:nil];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    self.delegate      = nil;
    self.gridView      = nil;
    self.assets        = nil;
    self.assetsGroup   = nil;
    self.assetsLibrary = nil;

    [super viewDidUnload];
}

#pragma mark - ABGridViewDelegate

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
    AssetCellView* item = ( AssetCellView* )[gridView dequeueReusableItem];
    if( item == nil )
    {
        AssetCellViewController* controller = [[[AssetCellViewController alloc] initWithNibName:@"AssetCellViewController" bundle:nil] autorelease];
        item = ( AssetCellView* )controller.view;
    }

    ALAsset* asset = [self.assets objectAtIndex:index];
    item.index           = index;
    item.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];

    // 再生時間
    id property = [asset valueForProperty:ALAssetPropertyDuration];
    if( ![property isEqual:ALErrorInvalidProperty] )
    {
        const NSInteger duration = [property integerValue];
        item.durationLabel.text = [NSString stringWithFormat:@"%d:%02d", ( int )( duration / 60 ), ( int )( duration % 60 )];
    }

    return item;
}

/**
 * アイテムが選択された時に発生します。
 *
 * @param gridView グリッド配置コンテナ。
 * @param view     アイテム。
 */
- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
    AssetCellView* item = (AssetCellView *)view;
    ALAsset* asset = [self.assets objectAtIndex:item.index];
    
    [self.delegate selectAssetDidFinish:self assetUrl:[[asset defaultRepresentation] url]];
}

#pragma mark - Private

/**
 * キャンセルされた時に発生します。
 *
 * @param sender イベント送信元。
 */
- (void)cancel:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

/**
 * アセット情報を読み込みます。
 */
- (void)loadAssets
{
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
    {
        if( result != nil )
        {
            // 動画のみ追加
            NSString* type = [result valueForProperty:ALAssetPropertyType];
            if( [type isEqualToString:ALAssetTypeVideo] )
            {
                [self.assets addObject:result];
            }
        }

        // 列挙完了
        if( index + 1 == self.assetsGroup.numberOfAssets )
        {
            [self performSelectorOnMainThread:@selector(reloadGridView) withObject:nil waitUntilDone:NO];
        }
    }];
}

/**
 * アセット情報のグループを読み込みます。
 */
- (void)loadAssetsGroups
{
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^( ALAssetsGroup *group, BOOL *stop )
    {
        if( group == nil ) { return; }

        *stop            = YES;
        self.assetsGroup = group;
        self.assets      = [NSMutableArray arrayWithCapacity:self.assetsGroup.numberOfAssets];
        [self loadAssets];
    }
    failureBlock:^( NSError *error )
    {
        
    }];
}

/**
 * グリッドを再読み込みします。
 */
- (void)reloadGridView
{
    [self.gridView reloadData];
}

@end
