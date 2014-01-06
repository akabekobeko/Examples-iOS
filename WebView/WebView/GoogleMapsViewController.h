//
//  GoogleMapsViewController.h
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIWebView 上の Google Maps API 連携をテストする画面です。
 */
@interface GoogleMapsViewController : UIViewController

/** 住所検索用のテキスト入力欄。 */
@property (weak, nonatomic) IBOutlet UITextField* textField;

/** Web ページ。 */
@property (weak, nonatomic) IBOutlet UIWebView* webView;

/** マップの中央座標を示す住所を表示するためのラベル。 */
@property (weak, nonatomic) IBOutlet UILabel* addressLabel;

@end
