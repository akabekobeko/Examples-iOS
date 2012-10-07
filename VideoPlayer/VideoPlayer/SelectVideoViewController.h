//
//  SelectVideoViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/07.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABGridView.h"

@protocol SelectVideoViewControllerDelegate;

////////////////////////////////////////////////////////////////////////////////
/**
 * カメラロールから動画を選択します。
 */
@interface SelectVideoViewController : UIViewController

@property (nonatomic, retain) IBOutlet ABGridView* gridView; //! 動画選択グリッド

+ (SelectVideoViewController *)controller:(id<SelectVideoViewControllerDelegate>)delegate;

@end

////////////////////////////////////////////////////////////////////////////////
/**
 * SelectVideoViewController に関するデリゲートです。
 */
@protocol SelectVideoViewControllerDelegate <NSObject>

- (void)selectVideoDidFinish:(SelectVideoViewController *)controller videoUrl:(NSURL *)videoUrl;

@end