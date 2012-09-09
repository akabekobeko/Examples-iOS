//
//  AppDelegate.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

@implementation AppDelegate

/**
 * メモリを開放します。
 */
- (void)dealloc
{
	[_window               release];
	[_navigationController release];

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
	MenuViewController* controller = [[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil] autorelease];

	self.navigationController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.window.rootViewController = self.navigationController;
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
