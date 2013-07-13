//
//  AppDelegate.m
//  MultipleTargets
//
//  Created by akabeko on 2013/07/13.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

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
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:[ViewController viewController]];
    navi.navigationBar.barStyle = UIBarStyleBlack;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navi];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
