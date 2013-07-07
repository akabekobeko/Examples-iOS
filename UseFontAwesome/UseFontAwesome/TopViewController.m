//
//  ViewController.m
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "TopViewController.h"
#import "IconListViewController.h"

#define MENU_ROW_ICON_LIST 0
#define MENU_ROW_COUNT     1

@interface TopViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TopViewController

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)viewController
{
    return [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
}

#pragma mark - View

/**
 * 画面が読み込まれるときに発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Use Font Awesome";

    self.menuTableView.dataSource = self;
    self.menuTableView.delegate   = self;
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [self setMenuTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UITableViewDataSource

/**
 * 指定セクションにおける行数を取得します。
 *
 * @param tableView テーブル。
 * @param section   セクション。
 *
 * @return 行数。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MENU_ROW_COUNT;
}

/**
 * 指定された位置のセルを取得します。
 *
 * @param tableView テーブル。
 * @param indexPath 取得するセルの位置。
 *
 * @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* const CellIdentifier = @"Cell";

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch( indexPath.row )
    {
    case MENU_ROW_ICON_LIST:
        cell.textLabel.text = @"Icon list";
        break;

    default:
        break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

/**
 * セルが選択された時に発生します。
 *
 * @param tableView テーブル。
 * @param indexPath 選択されたセルの位置。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch( indexPath.row )
    {
    case MENU_ROW_ICON_LIST:
        self.navigationItem.backBarButtonItem = [self backButton];
        [self.navigationController pushViewController:[IconListViewController viewController] animated:YES];
        break;

    default:
        break;
    }
}

/**
 * 戻るボタンを生成します。
 *
 * @return 戻るボタン。
 */
- (UIBarButtonItem *)backButton
{
    return [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
}

@end
