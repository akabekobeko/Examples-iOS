//
//  ViewController.h
//  FontEmbed
//
//  Created by Akabeko on 2013/01/14.
//  Copyright (c) 2013年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * トップ画面です。
 */
@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel* fontSampleLabelPenna;  //! Penna フォントのサンプル表示ラベル
@property (retain, nonatomic) IBOutlet UILabel* fontSampleLabelSeshat; //! Seshat フォントのサンプル表示ラベル

+ (id)controller;

@end
