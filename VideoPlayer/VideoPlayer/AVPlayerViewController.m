//
//  AVPlayerViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/30.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

NSString* const kStatusKey = @"status";
static void* AVPlayerViewControllerStatusObservationContext = &AVPlayerViewControllerStatusObservationContext;

@interface AVPlayerViewController ()

@property (nonatomic, retain) NSURL*        videoUrl;         //! 動画の URL
@property (nonatomic, retain) AVPlayerItem* playerItem;       //! 再生対象となるアイテム情報
@property (nonatomic, retain) AVPlayer*     videoPlayer;      //! 動画プレイヤー
@property (nonatomic, assign) id            playTimeObserver; //! 再生位置の更新タイマー通知ハンドラ
@property (nonatomic, assign) BOOL          isPlaying;        //! 動画が再生中であることを示す値

@end

@implementation AVPlayerViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @param videoUrl 動画の URL。
 *
 * @return インスタンス。
 */
+ (AVPlayerViewController *)controller:(NSURL *)videoUrl
{
    AVPlayerViewController* controller = [[[AVPlayerViewController alloc] initWithNibName:@"AVPlayerViewController" bundle:nil] autorelease];
    controller.videoUrl = videoUrl;

    return controller;
}

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    [self.videoPlayer pause];
    [self.playerItem removeObserver:self forKeyPath:kStatusKey context:AVPlayerViewControllerStatusObservationContext];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];

    self.videoPlayerView  = nil;
    self.videoPlayer      = nil;
    self.videoUrl         = nil;
    self.playerItem       = nil;
    self.currentTimeLabel = nil;
    self.seekBar          = nil;
    self.durationLabel    = nil;
    self.playButton       = nil;
    self.playerToolView   = nil;

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"AVPlayer";

    [self.playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
    self.playButton.contentMode = UIViewContentModeCenter;
    
    // 再生の準備が整うまで、操作系は無効としておく
    self.playButton.enabled = NO;
    self.seekBar.enabled    = NO;
    
    self.playerItem = [[[AVPlayerItem alloc] initWithURL:self.videoUrl] autorelease];
    [self.playerItem addObserver:self
                      forKeyPath:kStatusKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:AVPlayerViewControllerStatusObservationContext];

  	// 終了通知
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerDidPlayToEndTime:)
												 name:AVPlayerItemDidPlayToEndTimeNotification
											   object:self.playerItem];
  
    self.videoPlayer = [[[AVPlayer alloc] initWithPlayerItem:self.playerItem] autorelease];
    
    AVPlayerLayer* layer = ( AVPlayerLayer* )self.videoPlayerView.layer;
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    layer.player       = self.videoPlayer;

    // シングル タップ
	UITapGestureRecognizer* tapSingle = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSingle:)] autorelease];
	tapSingle.numberOfTapsRequired = 1;
	[self.videoPlayerView addGestureRecognizer:tapSingle];

    // ダブル タップ
	UITapGestureRecognizer* tapDouble = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDouble:)] autorelease];
	tapDouble.numberOfTapsRequired = 2;
	[self.videoPlayerView addGestureRecognizer:tapDouble];
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    [self.videoPlayer pause];
    [self.playerItem removeObserver:self forKeyPath:kStatusKey context:AVPlayerViewControllerStatusObservationContext];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    
    self.videoPlayerView  = nil;
    self.videoPlayer      = nil;
    self.videoUrl         = nil;
    self.playerItem       = nil;
    self.currentTimeLabel = nil;
    self.seekBar          = nil;
    self.durationLabel    = nil;
    self.playButton       = nil;
    self.playerToolView   = nil;

    [super viewDidUnload];
}

/**
 * 画面が表示される時に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setWantsFullScreenLayout:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.view setNeedsLayout];
}

/**
 * 他の画面へ切り替わる時に発生します。
 *
 * @param animated 表示アニメーションを有効にする場合は YES。それ以外は NO。
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [super viewWillDisappear:animated];
}

/**
 * プロパティが更新された時に発生します。
 *
 * @param keyPath 変更されたプロパティ。
 * @param object  変更されたプロパティを持つオブジェクト。
 * @param change  変更内容。
 * @param context 任意のユーザー データ。
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( context == AVPlayerViewControllerStatusObservationContext )
    {
        [self syncPlayButton];
        
        const AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch( status )
        {
        // 再生の準備が完了した
        case AVPlayerStatusReadyToPlay:
            [self setupSeekBar];
            self.playButton.enabled = YES;
            self.seekBar.enabled    = YES;
            break;

        // 不明
        case AVPlayerStatusUnknown:
            [self showError:nil];
            break;

  
        // 不正な状態
        case AVPlayerStatusFailed:
            {
                AVPlayerItem* playerItem = ( AVPlayerItem* )object;
                [self showError:playerItem.error];
            }
            break;
        }
    }
}

#pragma mark - Private

/**
 * 再生・一時停止ボタンが押された時に発生します。
 *
 * @param sender イベント送信元。
 */
- (void)play:(id)sender
{
    if( self.isPlaying )
    {
        self.isPlaying = NO;
        [self.videoPlayer pause];
    }
    else
    {
        self.isPlaying = YES;
        [self.videoPlayer play];
    }

    [self syncPlayButton];
}

/**
 * 動画再生が完了した時に発生します。
 *
 * @param notification 通知情報。
 */
- (void)playerDidPlayToEndTime:(NSNotification *)notification
{
	[self.videoPlayer seekToTime:kCMTimeZero];
    self.isPlaying = NO;
    [self syncPlayButton];

    // リピートする場合は再生を実行する
    //[self.videoPlayer play];
}

/**
 * 再生時間の更新ハンドラを削除します。
 */
- (void)removePlayerTimeObserver
{
    if( self.playTimeObserver == nil ) { return; }

    [self.videoPlayer removeTimeObserver:self.playTimeObserver];
    self.playTimeObserver = nil;
}

/**
 * 再生時間スライダーの操作によって値が更新された時に発生します。
 *
 * @param slider スライダー。
 */
- (void)seekBarValueChanged:(UISlider *)slider
{
	[self.videoPlayer seekToTime:CMTimeMakeWithSeconds( slider.value, NSEC_PER_SEC )];
}

/**
 * シークバーを初期化します。
 */
- (void)setupSeekBar
{
	self.seekBar.minimumValue = 0;
	self.seekBar.maximumValue = CMTimeGetSeconds( self.playerItem.duration );
	self.seekBar.value        = 0;
	[self.seekBar addTarget:self action:@selector(seekBarValueChanged:) forControlEvents:UIControlEventValueChanged];
    
	// 再生時間とシークバー位置を連動させるためのタイマー
	const double interval = ( 0.5f * self.seekBar.maximumValue ) / self.seekBar.bounds.size.width;
	const CMTime time     = CMTimeMakeWithSeconds( interval, NSEC_PER_SEC );
	self.playTimeObserver = [self.videoPlayer addPeriodicTimeObserverForInterval:time
                                                                           queue:NULL
                                                                      usingBlock:^( CMTime time ) { [self syncSeekBar]; }];

    self.durationLabel.text = [self timeToString:self.seekBar.maximumValue];
}

/**
 * エラー通知をおこないます。
 *
 * @param error エラー情報。
 */
- (void)showError:(NSError *)error
{
    [self removePlayerTimeObserver];
    [self syncSeekBar];
    self.playButton.enabled = NO;
    self.seekBar.enabled    = NO;
    
    if( error != nil )
    {
        UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                            message:[error localizedFailureReason]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] autorelease];
        [alertView show];
    }
}

/**
 * 再生位置スライダーを同期します。
 */
- (void)syncSeekBar
{
	const double duration = CMTimeGetSeconds( [self.videoPlayer.currentItem duration] );
	const double time     = CMTimeGetSeconds([self.videoPlayer currentTime]);
	const float  value    = ( self.seekBar.maximumValue - self.seekBar.minimumValue ) * time / duration + self.seekBar.minimumValue;
    
	[self.seekBar setValue:value];
    self.currentTimeLabel.text = [self timeToString:self.seekBar.value];
}

/**
 * 再生・一時停止ボタンの状態を同期します。
 */
- (void)syncPlayButton
{
    if( self.isPlaying )
    {
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    else
    {
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

/**
 * View がシングル タップされた時に発生します。
 *
 * @param sender イベント送信元。
 */
- (void)tapSingle:(UITapGestureRecognizer *)sender
{
    const BOOL isHidden = !self.navigationController.navigationBar.hidden;
    
	[[UIApplication sharedApplication] setStatusBarHidden:isHidden withAnimation:NO];
	[self.navigationController setNavigationBarHidden:isHidden animated:YES];
    [self.playerToolView setHidden:isHidden];
}

/**
 * View がダブル タップされた時に発生します。
 *
 * @param sender イベント送信元。
 */
- (void)tapDouble:(UITapGestureRecognizer *)sender
{
    AVPlayerLayer* layer = ( AVPlayerLayer* )self.videoPlayerView.layer;
    layer.videoGravity = ( layer.videoGravity == AVLayerVideoGravityResizeAspect ? AVLayerVideoGravityResizeAspectFill : AVLayerVideoGravityResizeAspect );
}

/**
 * 時間を文字列化します。
 *
 * @param value 時間。
 *
 * @return 文字列。
 */
- (NSString* )timeToString:(float)value
{
    const NSInteger time = value;
    return [NSString stringWithFormat:@"%d:%02d", ( int )( time / 60 ), ( int )( time % 60 )];
}

@end
