//
//  MenuViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "MenuViewController.h"
#import "AssetGroupViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MenuViewController

#pragma mark - View controller

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title                    = @"GridView Test Menu";
	self.menuTableView.dataSource = self;
	self.menuTableView.delegate   = self;
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
	[self setMenuTableView:nil];
	[super viewDidUnload];
}

/**
 * 画面が回転される時に発生します。
 *
 * @param interfaceOrientation 回転される向き。
 *
 * @return 回転可能なら YES。それ以外は NO。
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

#pragma mark - Table view data source

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
 * テーブルのセクション内における、行数を取得します。
 *
 * @param tableView テーブル。
 * @param section   セクション。
 *
 * @return 行数。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

/**
 * テーブルのセルを取得します。
 *
 * @param tableView テーブル。
 * @param indexPath セルの位置。
 *
 * @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* CellIdentifier = @"Cell";
	UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if( cell == nil )
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	switch( indexPath.row )
	{
	case 0: cell.textLabel.text = @"UIImageView";   break;
	case 1: cell.textLabel.text = @"Original Cell"; break;
			
	default:
		break;
	}
	
	return cell;
}

#pragma mark - Table view delegate

/**
 * テーブル上の行が選択された時に発生します。
 *
 * @param tableView テーブル。
 * @param indexPath セルの位置。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 戻るボタン
	UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = back;

	AssetGroupViewController* controller = [[AssetGroupViewController alloc] initWithNibName:@"AssetGroupViewController" bundle:nil];
	controller.isViewModeUIImage = ( indexPath.row == 0 );

	[self.navigationController pushViewController:controller animated:YES];
}

@end
