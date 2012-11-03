//
//  AlertTable.m
//  TestAlertView
//
//  Created by Akabeko on 11/12/11.
//  Copyright (c) 2011, Akabeko. All rights reserved.
//

#import "AlertTable.h"

@implementation AlertTable

#pragma mark - UITableViewDataSource

/**
 * テーブルのセクション数を取得します。
 *
 * @param tableView テーブル。
 *
 * @return セクション数。
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * セクションにおける行数を取得します。
 *
 * @param tableView テーブル。
 * @param section   セクション。
 *
 * @return 行数。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

/**
 * セルを取得します。
 *
 * @param tableView テーブル。
 * @param indexPath 位置。
 *
 * @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch( indexPath.row )
    {
    case 0: cell.textLabel.text = @"Apple";      break;
    case 1: cell.textLabel.text = @"Orange";     break;
    case 2: cell.textLabel.text = @"Banana";     break;
    case 3: cell.textLabel.text = @"Peach";      break;
    case 4: cell.textLabel.text = @"Strawberry"; break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

/**
 * セルが選択された時に発生します。
 *
 * @param tableView テーブル。
 * @param indexPath 位置。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"selected row: %d", indexPath.row );
}

@end
