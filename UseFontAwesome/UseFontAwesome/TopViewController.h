//
//  ViewController.h
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewController : UIViewController

/** メニュー選択用テーブル。 */
@property (weak, nonatomic) IBOutlet UITableView* menuTableView;

+ (id)viewController;

@end
