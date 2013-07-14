//
//  ViewController.m
//  MultipleTargets
//
//  Created by akabeko on 2013/07/13.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)viewController
{
    return [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
}

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
}

@end
