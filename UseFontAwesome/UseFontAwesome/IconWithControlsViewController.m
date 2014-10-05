//
//  IconWithControlsViewController.m
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "IconWithControlsViewController.h"
#import "IconInfo.h"

@implementation IconWithControlsViewController

/**
 * インスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (id)viewController
{
    return [[IconWithControlsViewController alloc] initWithNibName:@"IconWithControlsViewController" bundle:nil];
}

#pragma mark - View

/**
 * 画面が読み込まれるときに発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Icon with controls";

    [self setupButton];
    [self setupSegmentControls];
    [self setupBarButtons];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [self setButton:nil];
    [self setSegmentControl1:nil];
    [self setBarButtonItem1:nil];
    [self setBarButtonItem2:nil];
    [self setBarButtonItem3:nil];
    [self setBarButtonItem4:nil];
    [self setBarButtonItem5:nil];
    [self setBarButtonItem6:nil];
    [self setBarButtonItem7:nil];
    [self setBarButtonItem8:nil];
    [self setBarButtonItem9:nil];
    [self setBarButtonItem10:nil];
    [self setBarButtonItem11:nil];
    [self setBarButtonItem12:nil];
    [self setBarButtonItem13:nil];
    [self setBarButtonItem14:nil];
    [self setBarButtonItem15:nil];
    [self setBarButtonItem16:nil];
    [self setBarButtonItem17:nil];
    [self setBarButtonItem18:nil];
    [self setBarButtonItem19:nil];
    [self setBarButtonItem20:nil];
    [self setSegmentControl2:nil];
    [super viewDidUnload];
}

#pragma mark - Private

/**
 * バー ボタンを初期化します。
 *
 * @param barButtonItem  バー ボタン。
 * @param textAttributes テキスト属性。
 * @param icon           アイコンとなる文字の UNICODE。         
 */
- (void)setupBarButton:(UIBarButtonItem *)barButtonItem textAttributes:(NSDictionary *)textAttributes icon:(UniChar)icon
{
    [barButtonItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [barButtonItem setTitle:[IconInfo stringWithUnicode:icon]];
}

/**
 * バー ボタンを初期化します。
 */
- (void)setupBarButtons
{
    UIFont*       font = [UIFont fontWithName:@"FontAwesome" size:18.0];
    NSDictionary* dic  = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

    // Black Opaque - Plain
    [self setupBarButton:self.barButtonItem1 textAttributes:dic icon:0xF001];
    [self setupBarButton:self.barButtonItem2 textAttributes:dic icon:0xF002];
    [self setupBarButton:self.barButtonItem3 textAttributes:dic icon:0xF003];
    [self setupBarButton:self.barButtonItem4 textAttributes:dic icon:0xF004];
    [self setupBarButton:self.barButtonItem5 textAttributes:dic icon:0xF005];

    // Black Opaque - Borderd
    [self setupBarButton:self.barButtonItem6 textAttributes:dic icon:0xF006];
    [self setupBarButton:self.barButtonItem7 textAttributes:dic icon:0xF007];
    [self setupBarButton:self.barButtonItem8 textAttributes:dic icon:0xF008];
    [self setupBarButton:self.barButtonItem9 textAttributes:dic icon:0xF009];
    [self setupBarButton:self.barButtonItem10 textAttributes:dic icon:0xF00A];

    // Default - Plain
    [self setupBarButton:self.barButtonItem11 textAttributes:dic icon:0xF00B];
    [self setupBarButton:self.barButtonItem12 textAttributes:dic icon:0xF00C];
    [self setupBarButton:self.barButtonItem13 textAttributes:dic icon:0xF00D];
    [self setupBarButton:self.barButtonItem14 textAttributes:dic icon:0xF00E];
    [self setupBarButton:self.barButtonItem15 textAttributes:dic icon:0xF00F];

    // Default - Borderd
    [self setupBarButton:self.barButtonItem16 textAttributes:dic icon:0xF010];
    [self setupBarButton:self.barButtonItem17 textAttributes:dic icon:0xF011];
    [self setupBarButton:self.barButtonItem18 textAttributes:dic icon:0xF012];
    [self setupBarButton:self.barButtonItem19 textAttributes:dic icon:0xF013];
    [self setupBarButton:self.barButtonItem20 textAttributes:dic icon:0xF014];
}

/**
 * ボタンを初期化します。
 */
- (void)setupButton
{
    CGFloat fontSize = self.button.titleLabel.font.pointSize;
    [self.button.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:fontSize]];
    [self.button setTitle:[IconInfo stringWithUnicode:0xF030] forState:UIControlStateNormal];
}

/**
 * セグメント コントロールを初期化します。
 */
- (void)setupSegmentControls
{
    UIFont*       font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    NSDictionary* dic  = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    [self.segmentControl1 setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.segmentControl1 setTitle:[IconInfo stringWithUnicode:0xF04B] forSegmentAtIndex:0];
    [self.segmentControl1 setTitle:[IconInfo stringWithUnicode:0xF04C] forSegmentAtIndex:1];
    [self.segmentControl1 setTitle:[IconInfo stringWithUnicode:0xF055] forSegmentAtIndex:2];
    [self.segmentControl1 setTitle:[IconInfo stringWithUnicode:0xF056] forSegmentAtIndex:3];
    
    [self.segmentControl2 setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.segmentControl2 setTitle:[IconInfo stringWithUnicode:0xF099] forSegmentAtIndex:0];
    [self.segmentControl2 setTitle:[IconInfo stringWithUnicode:0xF09B] forSegmentAtIndex:1];
    [self.segmentControl2 setTitle:[IconInfo stringWithUnicode:0xF179] forSegmentAtIndex:2];
    [self.segmentControl2 setTitle:[IconInfo stringWithUnicode:0xF17B] forSegmentAtIndex:3];
}

@end
