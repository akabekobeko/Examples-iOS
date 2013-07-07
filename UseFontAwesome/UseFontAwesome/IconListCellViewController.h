//
//  IconListCellViewController.h
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * アイコン情報を表示するためのセルです。
 */
@interface IconListCell :  UITableViewCell

/** アイコン表示用ラベル。 */
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

/** アイコンの文字コード表示用ラベル。 */
@property (weak, nonatomic) IBOutlet UILabel* unicodeLabel;

+ (NSString *)sharedReuseIdentifier;

@end

/**
 * アイコン情報を表示するためのセルを管理します。
 */
@interface IconListCellViewController : UIViewController
{
@private
    /** アイコン情報を表示するためのセル。 */
    IBOutlet __weak IconListCell* _cell;
}

+ (id)viewController;

@end
