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
 *
 *
 *
 *
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MenuViewController* menu = [[[MenuViewController alloc] initWithNibName:@"" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:menu] autorelease];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
