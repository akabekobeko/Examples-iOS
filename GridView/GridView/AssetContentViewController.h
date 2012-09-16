//
//  AssetContentViewController.h
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABGridView.h"

@class ALAssetsGroup;

/**
 * ALAssetsLibrary におけるグループ内のコンテンツをグリッド表示します。
 */
@interface AssetContentViewController : UIViewController

@property (nonatomic, retain) IBOutlet ABGridView* assetGridView;     //! グリッド表示
@property (nonatomic, retain) ALAssetsGroup*       group;             //! ALAssetsLibrary におけるグループ
@property (nonatomic, assign) BOOL                 isViewModeUIImage; //! 表示モードが UIImage であることを示す値

@end
