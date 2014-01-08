//
//  BasicCoordinationViewController.m
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import "BasicCoordinationViewController.h"

@interface BasicCoordinationViewController () <UITextFieldDelegate, UIWebViewDelegate>

@end

@implementation BasicCoordinationViewController

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = LTEXT( @"Basic Coordination" );

    self.textField.delegate = self;
    self.webView.delegate   = self;

    [self loadHTML];
}

#pragma mark - UITextFieldDelegate

/**
 * UITextFiled のキーボード上でリターンが押された時に発生します。
 *
 * @param textField 対象となる UITextField。
 *
 * @return デフォルトのリターン押下処理を実行する場合は YES。
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if( [textField.text length] > 0 )
    {
        [self executeJavaScriptFunction:textField.text];
    }

    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIWebViewDelegate

/**
 * UIWebView 上でエラーが起きた時に発生します。
 *
 * @param webView 対象となる UIWebView。
 * @param error   エラー情報。
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    DLOG( @"Basic Coordination: Error = %@", [error description] );
}

/**
 * UIWebView 上のページ読み込みが完了した時に発生します。
 *
 * @param webView 対象となる UIWebView。
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLOG( @"Basic Coordination: Finish load" );
}

/**
 * UIWebView 上でリクエストによるページ遷移が開始された時に発生します。
 *
 * @param webView        対象となる UIWebView。
 * @param request        リクエスト。
 * @param navigationType ページ遷移の起点となった操作種別。
 *
 * @return ページ遷移を継続する場合は YES。キャンセルするなら NO。
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    static NSString* const callbackScheme = @"app-callback://";
    
    // アプリへのコールバックなら、その内容を表示
    NSString* url = [[request URL] absoluteString];
    if( [url hasPrefix:callbackScheme] )
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:LTEXT( @"From UIWebView" )
                                                        message:[url substringFromIndex:[callbackScheme length]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];

        return NO;
    }

    return YES;
}

#pragma mark - Private

/**
 * UIWebView 上に読み込まれた JavaScript の関数を実行します。
 *
 * @param param JavaScript の関数へ指定するパラメータ。
 */
- (void)executeJavaScriptFunction:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.webViewCallback('%@');", param];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}

/**
 * ローカル HTML を読み込みます。
 */
- (void)loadHTML
{
    NSString*     path    = [[NSBundle mainBundle] pathForResource:@"basic" ofType:@"html" inDirectory:@"html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.webView loadRequest:request];
}

@end
