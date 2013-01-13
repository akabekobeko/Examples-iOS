//
//  AppDelegate.m
//  FontEmbed
//
//  Created by Akabeko on 2013/01/14.
//  Copyright (c) 2013年 Akabeko. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    self.window               = nil;
    self.navigationController = nil;
    
    [super dealloc];
}

/**
 * アプリケーションが起動される時に発生します。
 *
 * @param application   アプリケーション情報。
 * @param launchOptions 起動オプション。
 *
 * @return 成功時は YES。それ以外は NO。
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[ViewController controller]] autorelease];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
