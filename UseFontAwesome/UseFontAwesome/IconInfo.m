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
        _icon    = [[NSString alloc] initWithCharacters:&unicode length:1];
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

@end
