//
//  AssetGroupViewController.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AssetGroupViewController.h"
#import "AssetContentViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetGroupViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) ALAssetsLibrary* assetLibrary; //! AssetsLibrary
@property (nonatomic, retain) NSMutableArray*  groups;       //! AssetsLibrary 内のグループ情報コレクション

@end

@implementation AssetGroupViewController

#pragma mark - Lifecycle

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
	[_groupTableView release];
	[_groups         release];
	[_assetLibrary   release];

	[super dealloc];
}

#pragma mark - View controller

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title                     = @"Select Group";
	self.groupTableView.dataSource = self;
	self.groupTableView.delegate   = self;

	self.assetLibrary = [[[ALAssetsLibrary alloc] init] autorelease];
	self.groups       = [[[NSMutableArray alloc] init] autorelease];

	// グループ一覧の列挙を非同期に実行
	[self performSelectorInBackground:@selector(enumGroups) withObject:nil];
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
	[self setGroupTableView:nil];
	[self setGroups:nil];
	[self setAssetLibrary:nil];

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
	return self.groups.count;
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
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	ALAssetsGroup* group = [self.groups objectAtIndex:indexPath.row];
	NSString*      name  = [group valueForProperty:ALAssetsGroupPropertyName];
	
	cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
	cell.textLabel.text  = [NSString stringWithFormat:@"%@ (%d)", name, group.numberOfAssets];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
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
	UIBarButtonItem* back = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
	self.navigationItem.backBarButtonItem = back;
	
	AssetContentViewController* controller = [[[AssetContentViewController alloc] initWithNibName:@"AssetContentViewController" bundle:nil] autorelease];
	controller.group             = [self.groups objectAtIndex:indexPath.row];
	controller.isViewModeUIImage = self.isViewModeUIImage;

	[self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private

/**
 * AssetsLibrary 内のグループを列挙します。
 */
- (void)enumGroups
{
	// グループ列挙
	void (^groupBlock)( ALAssetsGroup*, BOOL* ) = ^( ALAssetsGroup* group, BOOL* stop )
	{
		if( group == nil ) { return; }
		
		[self.groups addObject:group];
		[self performSelectorOnMainThread:@selector( reloadGroup ) withObject:nil waitUntilDone:NO];
	};

	// エラー
	void (^failureBlock)( NSError* ) = ^( NSError* error )
	{
		NSLog( @"Group enumurate error: %@", error );
	};
	
	[self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:groupBlock failureBlock:failureBlock];
}

/**
 * グループ一覧を更新します。
 */
- (void)reloadGroup
{
	[self.groupTableView reloadData];
}

@end
