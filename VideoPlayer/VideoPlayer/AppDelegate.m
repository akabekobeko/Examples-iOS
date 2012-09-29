//
//  AppDelegate.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/29.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

@implementation AppDelegate

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [_window               release];
    [_navigationController release];

    [super dealloc];
}

/**
 * アプリケーションが起動された時に発生します。
 *
 * @param application   アプリケーション。
 * @param launchOptions 起動オプション。
 *
 * @return 成功時は YES。それ以外は NO。
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MenuViewController* menu = [MenuViewController controller];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:menu] autorelease];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
