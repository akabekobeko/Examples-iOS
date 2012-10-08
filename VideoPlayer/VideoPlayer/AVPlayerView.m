//
//  AVPlayerView.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/10/08.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "AVPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVPlayerView

/**
 * レイヤーのクラス情報を取得します。
 *
 * @return レイヤー。
 */
+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

@end
