//
//  CustomAlertView.m
//  TestAlertView
//
//  Created by Akabeko on 11/12/10.
//  Copyright (c) 2011, Akabeko. All rights reserved.
//

#import "CustomAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define PROGRESS_MESSAGE @"%d / %d"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CustomAlertEvent

/**
 * CustomAlertView 用のイベント用データを表します。
 */
@interface CustomAlertEvent : NSObject

@property (nonatomic, assign) SEL selector; //! コールバック メソッド
@property (nonatomic, assign) id  userInfo; //! コールバックメソッドに指定されるパラメータ

- (id)initWithSelector:(SEL)aSelector userInfo:(id)aUserInfo;
@end

@implementation CustomAlertEvent

/**
 * インスタンスを初期化します。
 *
 * @param aSelector セレクター。
 * @param aUserInfo ユーザー データ。
 *
 * @return インスタンス。
 */
- (id)initWithSelector:(SEL)aSelector userInfo:(id)aUserInfo
{
	self = [super init];
	if( self )
	{
		self.selector = aSelector;
		self.userInfo = aUserInfo;
	}
	
	return self;
}

/**
 * メモリを解放します。
 */
-(void)dealloc
{
	self.selector = nil;
	self.userInfo = nil;
	
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CustomAlertView
@interface CustomAlertView()

@property (nonatomic, assign) id                       myDelegate;      //! 利用者
@property (nonatomic, retain) NSMutableArray*          events;          //! イベント情報のコレクション
@property (nonatomic, retain) UIActivityIndicatorView* innerIndicator;  //! インジケーター
@property (nonatomic, retain) UIProgressView*          innerProgress;   //! プログレスバー
@property (nonatomic, retain) UITableView*             innerTable;      //! テーブル
@property (nonatomic, retain) UITextField*             innerTextField;  //! テキスト フィールド

@end

@implementation CustomAlertView

#pragma mark - Lifecycle

/**
 * インスタンスを初期化します。
 *
 * @param title     タイトル。
 * @param message   本文。
 * @param aDelegate デリゲート。
 * @param button    ボタンの文言。
 *
 * @return インスタンス。
 */
- (id)initWithButton:(NSString *)title message:(NSString *)message delegate:(id)aDelegate button:(NSString *)button
{
	self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:button otherButtonTitles:nil];
	if( self )
	{
		self.delegate   = self;
		self.myDelegate = aDelegate;
		self.events     = [[[NSMutableArray alloc] init] autorelease];
		
		if( [self hasCancelButton] )
		{
			[self setFirstButtonDelegate:nil userInfo:nil];
		}
	}
    
	return self;
}

/**
 * インジケーター付きアラートのインスタンスを初期化します。
 *
 * @param title     タイトル。
 * @param message   本文。
 * @param aDelegate デリゲート。
 * @param button    ボタンの文言。
 *
 * @return インスタンス。
 */
- (id)initWithIndicator:(NSString *)title message:(NSString *)message delegate:(id)aDelegate button:(NSString *)button
{
	self = [[CustomAlertView alloc] initWithButton:title message:message delegate:aDelegate button:button];
	if( self )
	{
		self.innerIndicator = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake( 125, 80, 30, 30 )] autorelease];
		self.innerIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		[self addSubview:self.innerIndicator];
		[self.innerIndicator startAnimating];
	}
    
	return self;
}

/**
 * プログレスバー付きアラートのインスタンスを初期化します。
 *
 * @param title     タイトル。
 * @param aDelegate デリゲート。
 * @param button    ボタンの文言。
 *
 * @return インスタンス。
 */
- (id)initWithProgress:(NSString *)title delegate:(id)aDelegate button:(NSString *)button
{
	NSString* message = [NSString stringWithFormat:PROGRESS_MESSAGE, 0, 0];
	self = [[CustomAlertView alloc] initWithButton:title message:message delegate:aDelegate button:button];
	if( self )
	{
		self.innerProgress = [[[UIProgressView alloc] initWithFrame:CGRectMake( 12, 80, 260, 30 )] autorelease];
		[self addSubview:self.innerProgress];
	}
	
	return self;
}

/**
 * テーブル付きアラートのインスタンスを初期化します。
 *
 * @param title         タイトル。
 * @param aDelegate     デリゲート。
 * @param tableSource   テーブルのデータ取得先。
 * @param tableDelegate テーブルからのメッセージ通知先。
 * @param button        ボタンの文言。
 *
 * @return インスタンス。
 */
- (id)initWithTable:(NSString *)title message:(NSString *)message delegate:(id)aDelegate tableSource:(id<UITableViewDataSource>)tableSource tableDelegate:(id<UITableViewDelegate>)tableDelegate button:(NSString *)button
{
	self = [[CustomAlertView alloc] initWithButton:title message:message delegate:aDelegate button:button];
	if( self )
	{
		self.innerTable = [[[UITableView alloc] initWithFrame:CGRectMake( 12 , 80, 260, 200 ) style:UITableViewStylePlain] autorelease];
		self.innerTable.dataSource          = tableSource;
		self.innerTable.delegate            = tableDelegate;
		self.innerTable.layer.cornerRadius  = 4;
        
		[self addSubview:self.innerTable];
	}
    
	return self;
}

/**
 * テキスト フィールド付きアラートのインスタンスを初期化します。
 *
 * @param title        タイトル。
 * @param aDelegate    デリゲート。
 * @param textDelegate テキスト フィールドからのメッセージ通知先。
 * @param placeholder  テキスト フィールドのプレースホルダー文言。
 * @param button       ボタンの文言。
 *
 * @return インスタンス。
 */
- (id)initWithTextField:(NSString *)title message:(NSString *)message delegate:(id)aDelegate textDelegate:(id<UITextFieldDelegate>)textDelegate placeholder:(NSString*)placeholder button:(NSString *)button
{
    self = [[CustomAlertView alloc] initWithButton:title message:message delegate:aDelegate button:button];
    if( self )
    {
        self.innerTextField = [[[UITextField alloc] initWithFrame:CGRectMake( 12, 80, 260, 31 )] autorelease];
        self.innerTextField.delegate    = textDelegate;
        self.innerTextField.placeholder = placeholder;
        self.innerTextField.borderStyle = UITextBorderStyleRoundedRect;

        [self.innerTextField setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.innerTextField];
    }
    
    return self;
}

/**
 * ボタン付きアラートのインスタンスを生成します。
 *
 * @param title    タイトル。
 * @param message  本文。
 * @param delegate デリゲート。
 * @param button   ボタンの文言。
 *
 * @return インスタンス。
 */
+ (CustomAlertView *)alertWithButton:(NSString *)title message:(NSString *)message delegate:(id)delegate button:(NSString *)button
{
	return [[[CustomAlertView alloc] initWithButton:title message:message delegate:delegate button:button] autorelease];
}

/**
 * インジケーター付きアラートのインスタンスを生成します。
 *
 * @param title    タイトル。
 * @param message  本文。
 * @param delegate デリゲート。
 * @param button   ボタンの文言。
 *
 * @return インスタンス。
 */
+ (CustomAlertView *)alertWithIndicator:(NSString *)title message:(NSString *)message delegate:(id)delegate button:(NSString *)button
{
	return [[[CustomAlertView alloc] initWithIndicator:title message:message delegate:delegate button:button] autorelease];
}

/**
 * プログレスバー付きアラートのインスタンスを生成します。
 *
 * @param title    タイトル。
 * @param delegate デリゲート。
 * @param button   ボタンの文言。
 *
 * @return インスタンス。
 */
+ (CustomAlertView *)alertWithProgress:(NSString *)title delegate:(id)delegate button:(NSString *)button
{
	return [[[CustomAlertView alloc] initWithProgress:title delegate:delegate button:button] autorelease];
}

/**
 * テーブル付きアラートのインスタンスを生成します。
 *
 * @param title         タイトル。
 * @param aDelegate     デリゲート。
 * @param tableSource   テーブルのデータ取得先。
 * @param tableDelegate テーブルからのメッセージ通知先。
 * @param button        ボタンの文言。
 *
 * @return インスタンス。
 */
+ (CustomAlertView *)alertWithTable:(NSString *)title message:(NSString *)message delegate:(id)delegate tableSource:(id<UITableViewDataSource>)tableSource tableDelegate:(id<UITableViewDelegate>)tableDelegate button:(NSString *)button
{
	return [[[CustomAlertView alloc] initWithTable:title message:message delegate:delegate tableSource:tableSource tableDelegate:tableDelegate button:button] autorelease];
}

/**
 * テキスト フィールド付きアラートのインスタンスを生成します。
 *
 * @param title        タイトル。
 * @param aDelegate    デリゲート。
 * @param textDelegate テキスト フィールドからのメッセージ通知先。
 * @param placeholder  テキスト フィールドのプレースホルダー文言。
 * @param button       ボタンの文言。
 *
 * @return インスタンス。
 */
+ (CustomAlertView *)alertWithTextField:(NSString *)title message:(NSString *)message delegate:(id)delegate textDelegate:(id<UITextFieldDelegate>)textDelegate placeholder:(NSString*)placeholder button:(NSString *)button
{
	return [[[CustomAlertView alloc] initWithTextField:title message:message delegate:delegate textDelegate:textDelegate placeholder:placeholder button:button] autorelease];
}

/**
 * メモリを解放します。
 */
- (void)dealloc
{
	[self.innerIndicator stopAnimating];
    
	self.events         = nil;
	self.innerIndicator = nil;
    self.innerProgress  = nil;
    self.innerTable     = nil;
    self.innerTextField = nil;
    
	[super dealloc];
}

#pragma mark - Override

/**
 * アラートを表示します。
 */
- (void)show
{
    [super show];
    if( self.innerIndicator )
    {
        [self.innerIndicator startAnimating];
    }
}

#pragma mark - Public

/**
 * ボタンを追加します。
 *
 * @param title    ボタンのタイトル。
 * @param selector コールバック メソッド
 * @param userInfo コールバック メソッドに指定されるパラメータ。
 */
- (void)addButtonWithTitle:(NSString *)title selector:(SEL)selector userInfo:(id)userInfo
{
	[self addButtonWithTitle:title];
    
	CustomAlertEvent* event = [[CustomAlertEvent alloc] initWithSelector:selector userInfo:userInfo];
	[self.events addObject:event];
	[event release];
}

/**
 * アラートを閉じます。
 *
 * @param buttonIndex 閉じる時に押されたボタンのインデックス。ボタンの無いアラートの場合は 0 を指定します。
 */
- (void)close:(NSInteger)buttonIndex
{
	[self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

/**
 * はじめのボタンが押された時のハンドラを設定します。
 *
 * @param selector コールバック メソッド
 * @param userInfo コールバック メソッドに指定されるパラメータ。
 */
- (void)setFirstButtonDelegate:(SEL)selector userInfo:(id)userInfo
{
	if( [self hasCancelButton] )
	{
		if( self.events.count > 0 )
		{
			[self.events removeObjectAtIndex:0];
		}
        
		CustomAlertEvent* event = [[CustomAlertEvent alloc] initWithSelector:selector userInfo:userInfo];
		[self.events insertObject:event atIndex:0];
		[event release];
	}
}

/**
 * 進捗を更新します。
 *
 * @param value 処理数。
 * @param total 処理の総数。
 */
- (void)updateProgress:(NSInteger)value total:(NSInteger)total
{
	if( self.innerProgress )
	{
		[self setMessage:[NSString stringWithFormat:PROGRESS_MESSAGE, value, total]];
		self.innerProgress.progress = ( float )value / ( float )total;
	}
}

#pragma mark - UIAlertViewDelegate

/**
 * UIAlertView 上のボタンがクリックされた時に発生します。
 *
 * @param alertView   操作の行われた UIAlertView。
 * @param buttonIndex ボタンのインデックス。
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	CustomAlertEvent* event = [self.events objectAtIndex:buttonIndex];
	if( event.selector && [self.myDelegate respondsToSelector:event.selector] )
	{
		[self.myDelegate performSelector:event.selector withObject:event.userInfo];
	}
}

/**
 * UIAlertView が表示される時に発生します。
 *
 * @param alertView 表示対象となる UIAlertView。
 */
- (void)willPresentAlertView:(UIAlertView *)alertView
{
	// ボタンが皆無なら、表示関連の調整は不要
	if( self.numberOfButtons < 1 ) { return; }
    
	NSInteger offsetY = 0;
	NSInteger offsetH = 0;
    
	if( self.innerIndicator )
	{
		offsetY = self.innerIndicator.frame.origin.y;
		offsetH = self.innerIndicator.frame.size.height;
	}
	else if( self.innerProgress )
	{
		offsetY = self.innerProgress.frame.origin.y;
		offsetH = self.innerProgress.frame.size.height;
	}
	else if( self.innerTable )
	{
		offsetY = self.innerTable.frame.origin.y;
		offsetH = self.innerTable.frame.size.height;
	}
	else if( self.innerTextField )
	{
		offsetY = self.innerTextField.frame.origin.y;
		offsetH = self.innerTextField.frame.size.height;
	}
	else
	{
		return;
	}
    
	const NSInteger padding = 8;
    
	// アラート本体の位置とサイズを調整。
	// 垂直位置を追加したコントロールの半分、ずらすことで中央としている。
	// ただし、小数点以下の値が混じると描画がぼやけるため、offsetH を意図的に NSInteger で宣言している。
	//
	CGRect frame = self.frame;
	frame.origin.y    -= offsetH / 2;
	frame.size.height += offsetH + padding;
	self.frame = frame;
    
	// 追加コントロール以下のものを位置調整
	for( UIView* view in self.subviews )
	{
		frame = view.frame;
		if( offsetY < frame.origin.y )
		{
			frame.origin.y += offsetH + padding;
			view.frame = frame;
		}
	}
}

#pragma mark - Private

/**
 * キャンセル ボタンが設定されていることを調べます。
 *
 * @return 設定されている場合は YES。それ以外は NO。
 */
- (BOOL)hasCancelButton
{
	return ( self.cancelButtonIndex == 0 );
}

@end
