//
//  AssetCellViewController.h
//  GridView
//
//  Created by Akabeko on 2012/09/17.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
/**
 * アセット情報を表示するためのセルです。
 */
@interface AssetCellView : UIView

@property (nonatomic, retain) IBOutlet UIImageView* imageView; //! 画像
@property (nonatomic, assign) NSInteger             index;     //! インデックス

@end

////////////////////////////////////////////////////////////////////////////////
/**
 * AssetCellView を管理します。
 */
@interface AssetCellViewController : UIViewController
{
@private
    IBOutlet AssetCellView* _cell; //! セル
}

@end
