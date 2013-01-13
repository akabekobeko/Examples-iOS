//
//  ViewController.m
//  FontEmbed
//
//  Created by Akabeko on 2013/01/14.
//  Copyright (c) 2013年 Akabeko. All rights reserved.
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
    self.fontSampleLabelPenna  = nil;
    self.fontSampleLabelSeshat = nil;

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Custom Fonts"];
    [self.fontSampleLabelPenna  setFont:[UIFont fontWithName:@"Penna"  size:17]];    
    [self.fontSampleLabelSeshat setFont:[UIFont fontWithName:@"Seshat" size:17]];
}

@end
