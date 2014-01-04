//
//  ViewController.m
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import "TopMenuViewController.h"

#define TABLE_SECTION_COUNT 1

#define TABLE_ROW_BASIC_COORDINATION 0
#define TABLE_ROW_GOOGLE_MAPS_API    1
#define TABLE_ROW_COUNT              2

@interface TopMenuViewController ()

@end

@implementation TopMenuViewController

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = LTEXT( @"UIWebView Coordination" );
}

#pragma mark - Table View

/**
 * テーブルのセクション数を取得します。
 *
 * @param tableView テーブル。
 *
 * @return セクション数。
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_SECTION_COUNT;
}

/**
 * テーブルの指定セクションにおける行数を取得します。
 *
 * @param tableView テーブル。
 * @param section   セクション。
 *
 * @return 行数。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TABLE_ROW_COUNT;
}

/**
 * テーブルのセルを取得します。
 *
 * @param tableView テーブル。
 * @param indexPath 取得するセルの位置。
 *
 * @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    switch( indexPath.row )
    {
    case TABLE_ROW_BASIC_COORDINATION:
        cell.textLabel.text = LTEXT( @"Basic Coordination" );
        break;

    case TABLE_ROW_GOOGLE_MAPS_API:
        cell.textLabel.text = LTEXT( @"Google Maps API" );
        break;

    default:
        break;
    }

    return cell;
}

/**
 * テーブル上で行が選択された時に発生します。
 *
 * @param tableView テーブル。
 * @param indexPath 選択された行の位置情報。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch( indexPath.row )
    {
    case TABLE_ROW_BASIC_COORDINATION:
        [self performSegueWithIdentifier:@"Basic Coordination" sender:self];
        break;

    case TABLE_ROW_GOOGLE_MAPS_API:
        [self performSegueWithIdentifier:@"Google Maps API" sender:self];
        break;

    default:
        break;
    }
}

@end
