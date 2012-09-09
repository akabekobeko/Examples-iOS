//
//  AppDelegate.h
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

/**
 * アプリケーションのライフサイクルを管理します。
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow*               window;               //! メイン ウィンドウ
@property (nonatomic, retain) UINavigationController* navigationController; //! ナビゲーション

@end
