//
//  UIUtility.m
//  CustomAlertView
//
//  Created by Akabeko on 2012/11/03.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "UIUtility.h"

@implementation UIUtility

/**
 * 文字列リソースからテキストを取得します。
 *
 * @param key リソース識別子。
 *
 * @return
 */
+ (NSString *)text:(NSString *)key
{
    return NSLocalizedString( key, @"" );
}

@end
