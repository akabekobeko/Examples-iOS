//
//  BasicCoordinationViewController.h
//  WebView
//
//  Created by akabeko on 2014/01/05.
//  Copyright (c) 2014年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIWebView の基本的な連携をテストする画面です。
 */
@interface BasicCoordinationViewController : UIViewController

/** Web ページに送信するテキスト入力欄。 */
@property (weak, nonatomic) IBOutlet UITextField* textField;

/** Web ページ。 */
@property (weak, nonatomic) IBOutlet UIWebView* webView;

@end
