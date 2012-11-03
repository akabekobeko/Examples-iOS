//
//  CustomAlertView.h
//  TestAlertView
//
//  Created by Akabeko on 11/12/10.
//  Copyright (c) 2011, Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIAlertView を拡張したコントロールです。
 */
@interface CustomAlertView : UIAlertView<UIAlertViewDelegate>
+ (CustomAlertView *)alertWithButton:(NSString*)title message:(NSString *)message delegate:(id)delegate button:(NSString *)button;
+ (CustomAlertView *)alertWithIndicator:(NSString*)title message:(NSString *)message delegate:(id)delegate button:(NSString *)button;
+ (CustomAlertView *)alertWithProgress:(NSString *)title delegate:(id)delegate button:(NSString *)button;
+ (CustomAlertView *)alertWithTable:(NSString *)title message:(NSString *)message delegate:(id)delegate tableSource:(id<UITableViewDataSource>)tableSource tableDelegate:(id<UITableViewDelegate>)tableDelegate button:(NSString *)button;
+ (CustomAlertView *)alertWithTextField:(NSString *)title message:(NSString *)message delegate:(id)delegate textDelegate:(id<UITextFieldDelegate>)textDelegate placeholder:(NSString *)placeholder button:(NSString *)button;

- (void)addButtonWithTitle:(NSString *)title selector:(SEL)selector userInfo:(id)userInfo;
- (void)close:(NSInteger)buttonIndex;
- (void)setFirstButtonDelegate:(SEL)selector userInfo:(id)userInfo;
- (void)updateProgress:(NSInteger)value total:(NSInteger)total;
@end
