//
//  AVPlayerViewController.h
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerView.h"

/**
 * AVPlayer による動画再生をテストする画面です。
 */
@interface AVPlayerViewController : UIViewController

@property (nonatomic, retain) IBOutlet AVPlayerView* videoPlayerView;  //! 動画表示
@property (nonatomic, retain) IBOutlet UIView*       playerToolView;   //! プレイヤー操作部
@property (nonatomic, retain) IBOutlet UIButton*     playButton;       //! 再生・一時停止ボタン
@property (nonatomic, retain) IBOutlet UILabel*      currentTimeLabel; //! 現在の再生時間ラベル
@property (nonatomic, retain) IBOutlet UISlider*     seekBar;          //! 再生位置
@property (nonatomic, retain) IBOutlet UILabel*      durationLabel;    //! 演奏時間ラベル

+ (AVPlayerViewController *)controller:(NSURL *)videoUrl;

@end
