//
//  ThumbnailCellViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/08.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
/**
 * サムネイル画像を表示するためのセルです。
 */
@interface AssetCellView : UIView

@property (nonatomic, retain) IBOutlet UIImageView* imageView;     //! 画像を表示する領域
@property (nonatomic, retain) IBOutlet UIView*      propertyView;  //! コンテンツ情報を表示する領域
@property (nonatomic, retain) IBOutlet UILabel*     durationLabel; //! 再生時間ラベル
@property (nonatomic, assign) NSInteger             index;         //! インデックス情報

@end

////////////////////////////////////////////////////////////////////////////////
/**
 * ThumbnailCellView を管理します。
 */
@interface AssetCellViewController : UIViewController
{
@private
    IBOutlet AssetCellView* _cell; //! セル
}

@end
