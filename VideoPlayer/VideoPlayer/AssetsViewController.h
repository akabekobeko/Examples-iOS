//
//  SelectVideoViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/07.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABGridView.h"

@protocol AssetsViewControllerDelegate;
@class ALAssetsGroup;

////////////////////////////////////////////////////////////////////////////////
/**
 * カメラロールから動画を選択します。
 */
@interface AssetsViewController : UIViewController

@property (nonatomic, retain) IBOutlet ABGridView* gridView; //! 動画選択グリッド

+ (UIViewController *)controller:(id<AssetsViewControllerDelegate>)delegate;

@end

////////////////////////////////////////////////////////////////////////////////
/**
 * SelectVideoViewController に関するデリゲートです。
 */
@protocol AssetsViewControllerDelegate <NSObject>

- (void)selectAssetDidFinish:(AssetsViewController *)controller assetUrl:(NSURL *)assetUrl;

@end