//
//  IconInfo.m
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import "IconInfo.h"

@implementation IconInfo

/**
 * インスタンスを初期化します。
 *
 * @param unicode Font Awesome のアイコンに対応する文字コード ( UNICODE )。
 *
 * @return インスタンス。
 */
- (id)init:(UniChar)unicode
{
    self = [super init];
    if( self )
    {
        _icon    = [IconInfo stringWithUnicode:unicode];
        _unicode = unicode;
    }

    return self;
}

/**
 * インスタンスを生成します。
 *
 * @param unicode Font Awesome のアイコンに対応する文字コード ( UNICODE )。
 *
 * @return インスタンス。
 */
+ (id)iconInfo:(UniChar)unicode
{
    return [[IconInfo alloc] init:unicode];
}

/**
 * UNICODE の値から文字を取得します。
 *
 * @param unicode UNICODE の値。
 *
 * @return 文字。
 */
+ (NSString *)stringWithUnicode:(UniChar)unicode
{
    return [[NSString alloc] initWithCharacters:&unicode length:1];
}

@end
