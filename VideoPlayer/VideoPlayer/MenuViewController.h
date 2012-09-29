//
//  ViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/29.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * メニュー画面です。
 */
@interface MenuViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView* menuTableView; //! メニュー表示テーブル

+ (MenuViewController *)controller;

@end
