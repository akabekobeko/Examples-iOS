//
//  IconListViewController.m
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "IconListViewController.h"
#import "IconListCellViewController.h"
#import "IconInfo.h"

@interface IconListViewController () <UITableViewDataSource>

/** アイコン情報のコレクション。 */
@property (nonatomic) NSArray* iconInfos;

@end

@implementation IconListViewController

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)viewController
{
    return [[IconListViewController alloc] initWithNibName:@"IconListViewController" bundle:nil];
}

#pragma mark - View

/**
 * 画面が読み込まれるときに発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title                    = @"Icon list";
    self.iconTableView.dataSource = self;

    [self setupIconInfos];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [self setIconTableView:nil];
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
    return [self.iconInfos count];
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
    IconListCell* cell = [tableView dequeueReusableCellWithIdentifier:[IconListCell sharedReuseIdentifier]];
    if( cell == nil )
    {
        cell = ( IconListCell* )[[IconListCellViewController viewController] view];
    }

    IconInfo* info = self.iconInfos[ indexPath.row ];
    cell.iconLabel.text    = info.icon;
    cell.unicodeLabel.text = [NSString stringWithFormat:@"%04X", info.unicode];

    return cell;
}


#pragma mark - Private

/**
 * アイコン情報コレクションを初期化します。
 */
- (void)setupIconInfos
{
    // font-awesome.css を参考に、始点〜終点を定義
    const UniChar beginCode = 0xF000;
    const UniChar endCode   = 0xF18B;

    // 欠番を考慮するならループではなくテーブルのほうがよい ( 今回は欠番も含める )
    NSMutableArray* infos = [NSMutableArray arrayWithCapacity:( endCode - beginCode ) + 1];
    for( UniChar unicode = beginCode; unicode <= endCode; ++unicode )
    {
        [infos addObject:[IconInfo iconInfo:unicode]];
    }

    self.iconInfos = infos;
}

@end
