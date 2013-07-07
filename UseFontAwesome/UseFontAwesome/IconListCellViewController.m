//
//  IconListCellViewController.m
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "IconListCellViewController.h"

@implementation IconListCell

/**
 * セルを再利用するための識別子を取得します。
 *
 * @return 識別子。
 */
- (NSString *)reuseIdentifier
{
    return [IconListCell sharedReuseIdentifier];
}

/**
 * セルを再利用するための規定の識別子を取得します。
 *
 * @return 識別子。
 */
+ (NSString *)sharedReuseIdentifier
{
    return @"Cell";
}

@end

@implementation IconListCellViewController

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)viewController
{
    return [[IconListCellViewController alloc] initWithNibName:@"IconListCellViewController" bundle:nil];
}

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat fontSize = _cell.iconLabel.font.pointSize;
    [_cell.iconLabel setFont:[UIFont fontWithName:@"FontAwesome" size:fontSize]];
}

@end
