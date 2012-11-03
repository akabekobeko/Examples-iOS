//
//  ViewController.h
//  CustomAlertView
//
//  Created by Akabeko on 2012/11/03.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * テスト メニュー画面です。
 */
@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView* menuTableView; //! メニュー テーブル

+ (id)controller;

@end
