//
//  ViewController.m
//  InAppPurchase
//
//  Created by Akabeko on 2012/11/10.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)controller
{
    return [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
}

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{    
    [super dealloc];
}

#pragma mark - Views

/**
 * 画面が読み込まれた時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
