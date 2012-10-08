//
//  MoviePlayerViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * MPMoviePlayerController による動画再生をテストする画面です。
 */
@interface MoviePlayerViewController : UIViewController

+ (MoviePlayerViewController *)controller:(NSURL *)videoUrl;

@end
