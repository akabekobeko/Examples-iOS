//
//  IconListViewController.h
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Font Awesome に含まれるアイコンをリスト表示します。
 */
@interface IconListViewController : UIViewController

/** アイコン情報を表示するテーブル。 */
@property (weak, nonatomic) IBOutlet UITableView* iconTableView;

+ (id)viewController;

@end
