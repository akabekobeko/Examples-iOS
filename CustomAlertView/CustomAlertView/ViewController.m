//
//  ViewController.m
//  CustomAlertView
//
//  Created by Akabeko on 2012/11/03.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"
#import "AlertTable.h"
#import "UIUtility.h"

// テーブルの行
#define TABLE_ROW_BUTTON    ( 0 )
#define TABLE_ROW_TEXTFIELD ( 1 )
#define TABLE_ROW_TABLE     ( 2 )
#define TABLE_ROW_PROGRESS  ( 3 )
#define TABLE_ROW_INDICATOR ( 4 )
#define TABLE_ROW_COUNT     ( 5 )

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) AlertTable*      alertTable;     //! アラートに表示するテーブルの内容
@property (nonatomic, retain) CustomAlertView* alertIndicator; //! インジケーター付きアラート
@property (nonatomic, retain) CustomAlertView* alertProgress;  //! プログレスバー付きアラート
@property (nonatomic, retain) NSTimer*         timer;          //! タイマー
@property (nonatomic, assign) NSInteger        progressValue;  //! 進捗の算出に使用する処理数

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
    [self viewDidUnload];

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれた時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [UIUtility text:@"ALERT_TYPE_VIEW_TITLE"];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.menuTableView.dataSource = self;
    self.menuTableView.delegate   = self;
    
	self.alertTable     = [[[AlertTable alloc] init] autorelease];
	self.alertIndicator = [CustomAlertView alertWithIndicator:[UIUtility text:@"ALERT_TYPE_INDICATOR"]
													  message:[UIUtility text:@"ALERT_TYPE_INDICATOR_MESSAGE"]
													 delegate:self
													   button:nil];
	self.alertProgress  = [CustomAlertView alertWithProgress:[UIUtility text:@"ALERT_TYPE_INDICATOR_MESSAGE"]
												   delegate:self
													 button:[UIUtility text:@"CANCEL"]];
	[self.alertProgress setFirstButtonDelegate:@selector( alertProgressCancel: ) userInfo:nil];
}

/**
 * 画面が破棄されるときに発生します。
 */
- (void)viewDidUnload
{
 	[self stopTimer];
	[self.alertIndicator close:0];
	[self.alertProgress  close:0];
 
    self.menuTableView  = nil;
	self.alertTable     = nil;
	self.alertIndicator = nil;
	self.alertProgress  = nil;

    [super viewDidUnload];
}

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
    return TABLE_ROW_COUNT;
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
    case TABLE_ROW_BUTTON:    cell.textLabel.text = [UIUtility text:@"ALERT_TYPE_BUTTON"];    break;
    case TABLE_ROW_TEXTFIELD: cell.textLabel.text = [UIUtility text:@"ALERT_TYPE_TEXTFIELD"]; break;
    case TABLE_ROW_TABLE:     cell.textLabel.text = [UIUtility text:@"ALERT_TYPE_TABLE"];     break;
    case TABLE_ROW_PROGRESS:  cell.textLabel.text = [UIUtility text:@"ALERT_TYPE_PROGRESS"];  break;
    case TABLE_ROW_INDICATOR: cell.textLabel.text = [UIUtility text:@"ALERT_TYPE_INDICATOR"]; break;
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
    switch( indexPath.row )
    {
    case TABLE_ROW_BUTTON:    [self showAlertButton];    break;
    case TABLE_ROW_TEXTFIELD: [self showAlertTextField]; break;
    case TABLE_ROW_TABLE:     [self showAlertTable];     break;
    case TABLE_ROW_PROGRESS:  [self showAlertProgress];  break;
    case TABLE_ROW_INDICATOR: [self showAlertIndicator]; break;
    }
}

#pragma mark - UITextFieldDelegate

/**
 * テキスト フィールドの編集が完了した時に発生します。
 *
 * @param 編集の完了したテキスト フィールド
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog( @"text = %@", textField.text );
}

#pragma mark - Private

/**
 * インジケータ付きアラートのタイマーにより発生します。
 *
 * @param timer タイマー。
 */
- (void)alertIndicatorTimer:(NSTimer *)timer
{
    [self.alertIndicator close:0];
    [self stopTimer];
}

/**
 * プログレスバー付きアラートのキャンセル ボタンが押された時に発生します。
 *
 * @param userInfo ユーザー情報。
 */
- (void)alertProgressCancel:(id)userInfo
{
    [self stopTimer];
}

/**
 * プログレスバー付きアラートのタイマーにより発生します。
 *
 * @param timer タイマー。
 */
- (void)alertProgressTimer:(NSTimer *)timer
{
	[self.alertProgress updateProgress:++self.progressValue total:10];
	if( self.progressValue == 10 )
	{
		[self.alertProgress close:0];
	}
}

/**
 * CustomAlertView 上のボタンが押された時に発生します。
 *
 * @param userInfo ユーザー情報。
 */
- (void)selectAlertNormalButton:(id)userInfo
{
	if( userInfo )
	{
		NSString* text = ( NSString* )userInfo;
		CustomAlertView* alert = [CustomAlertView alertWithButton:nil message:text delegate:nil button:@"OK"];
		[alert show];
	}
}

/**
 * ボタン付きアラートを表示します。
 */
- (void)showAlertButton
{
    NSString* title   = [UIUtility text:@"ALERT_TYPE_BUTTON"];
    NSString* message = [UIUtility text:@"ALERT_TYPE_BUTTON_MESSAGE"];
    NSString* cancel  = [UIUtility text:@"CANCEL"];

    CustomAlertView* alert = [CustomAlertView alertWithButton:title message:message delegate:self button:cancel];
    [alert addButtonWithTitle:@"OK" selector:@selector( selectAlertNormalButton: ) userInfo:@"OK Button"];
    [alert setFirstButtonDelegate:@selector( selectAlertNormalButton: ) userInfo:@"Cancel Button"];
    [alert show];
}

/**
 * インジケータ付きアラートを表示します。
 */
- (void)showAlertIndicator
{
    [self.alertIndicator show];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector( alertIndicatorTimer: )
                                                userInfo:nil
                                                 repeats:NO];
}

/**
 * プログレスバー付きアラートを表示します。
 */
- (void)showAlertProgress
{
    self.progressValue = 0;
    [self.alertProgress updateProgress:self.progressValue total:10];
    [self.alertProgress show];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector( alertProgressTimer: )
                                                userInfo:nil
                                                 repeats:YES];
}

/**
 * テーブル付きアラートを表示します。
 */
- (void)showAlertTable
{
    NSString* title   = [UIUtility text:@"ALERT_TYPE_TABLE"];
    NSString* message = [UIUtility text:@"ALERT_TYPE_TABLE_MESSAGE"];
    NSString* button  = [UIUtility text:@"OK"];
	
    CustomAlertView* alert = [CustomAlertView alertWithTable:title message:message delegate:self tableSource:self.alertTable tableDelegate:self.alertTable button:button];
    [alert show];
}

/**
 * テキスト フィールド付きアラートを表示します。
 */
- (void)showAlertTextField
{
    NSString* title   = [UIUtility text:@"ALERT_TYPE_TEXTFIELD"];
    NSString* message = [UIUtility text:@"ALERT_TYPE_TEXTFIELD_MESSAGE"];
    NSString* button  = [UIUtility text:@"OK"];
	
    CustomAlertView* alert = [CustomAlertView alertWithTextField:title message:message delegate:self textDelegate:self placeholder:message button:button];
    [alert show];
}

/**
 * タイマーを停止します。
 */
- (void)stopTimer
{
	[self.timer invalidate];
	self.timer = nil;
}

@end
