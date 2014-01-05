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

/** Web ページ。 */
@property (weak, nonatomic) IBOutlet UIWebView* webView;

@end
