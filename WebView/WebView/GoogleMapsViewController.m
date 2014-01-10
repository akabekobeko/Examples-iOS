//
//  GoogleMapsViewController.m
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import "GoogleMapsViewController.h"

@interface GoogleMapsViewController () <UITextFieldDelegate, UIWebViewDelegate>

@end

@implementation GoogleMapsViewController

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = LTEXT( @"Google Maps API" );

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
        [self moveToMapCenter:textField.text];
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
    DLOG( @"Google Maps API Demo: Error = %@", [error description] );
}

/**
 * UIWebView 上のページ読み込みが完了した時に発生します。
 *
 * @param webView 対象となる UIWebView。
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLOG( @"Google Maps API Demo: Finish load" );
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
    static NSString* const callbackScheme = @"app-callback://map?";
    
    // アプリへのコールバックなら、その内容を表示
    NSString* url = [[request URL] absoluteString];
    if( [url hasPrefix:callbackScheme] )
    {
        // パラメータ解析
        NSDictionary* params    = [self parseUrlParameters:url];
        NSString*     address   = params[ @"address" ];
        NSString*     latitude  = params[ @"lat" ];
        NSString*     longitude = params[ @"lng" ];
        DLOG( @"address = %@, latitude = %@, longitude = %@", address, latitude, longitude );

        self.addressLabel.text = address;
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Private

/**
 * ローカル HTML を読み込みます。
 */
- (void)loadHTML
{
    NSString*     path    = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"html" inDirectory:@"html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];

    [self.webView loadRequest:request];
}

/**
 * マップの中央位置を指定された住所の位置へ移動させます。
 *
 * @param address 住所。ジオコーディングによって検索されます。
 */
- (void)moveToMapCenter:(NSString *)address
{
    NSString* region = LTEXT( @"Map Region" );
    NSString* script = [NSString stringWithFormat:@"window.webViewCallbackSearchAddress('%@','%@');", address, region];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}

/**
 * URL におけるパラメータ部分を解析して取得します。
 *
 * @param url URL。
 *
 * @return 解析結果。
 */
- (NSDictionary *)parseUrlParameters:(NSString *)url
{
    NSRange range = [url rangeOfString:@"?"];
    if( range.location == NSNotFound ) { [NSDictionary dictionary]; }

    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    NSArray*             params = [[url substringFromIndex:range.location + 1] componentsSeparatedByString:@"&"];

    for ( NSString* param in params )
    {
        NSArray* keyValuePair = [param componentsSeparatedByString:@"="];
        if( [keyValuePair count] >= 2 )
        {
            NSString* value = [keyValuePair[ 1 ] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [result setObject:value forKey:keyValuePair[ 0 ]];
        }
    }

    return result;
}

@end
