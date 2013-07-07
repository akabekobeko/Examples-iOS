//
//  IconWithControlsViewController.h
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Font Awesome のアイコンと標準コントロールの組み合わせを表示します。
 */
@interface IconWithControlsViewController : UIViewController

// Button
@property (weak, nonatomic) IBOutlet UIButton* button;

// Segment Control
@property (weak, nonatomic) IBOutlet UISegmentedControl* segmentControl1;
@property (weak, nonatomic) IBOutlet UISegmentedControl* segmentControl2;

// Black Opaque - Plain
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem3;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem4;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem5;

// Black Opaque - Borderd
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem6;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem7;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem8;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem9;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem10;

// Default - Plain
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem11;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem12;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem13;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem14;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem15;

// Default - Borderd
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem16;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem17;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem18;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem19;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* barButtonItem20;

+ (id)viewController;

@end
