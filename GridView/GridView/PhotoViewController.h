//
//  PhotoViewController.h
//  GridView
//
//  Created by Akabeko on 2012/09/17.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 画像を表示します。
 */
@interface PhotoViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView* imageView; //! 画像
@property (nonatomic, retain) UIImage* image; //!

@end
