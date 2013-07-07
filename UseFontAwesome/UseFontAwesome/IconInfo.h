//
//  IconInfo.h
//  UseFontAwesome
//
//  Created by akabeko on 2013/07/07.
//  Copyright (c) 2013年 akabeko. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Font Awesome のアイコン情報を表します。
 */
@interface IconInfo : NSObject

/** Font Awesome のアイコンに対応する文字。 */
@property (readonly, nonatomic) NSString* icon;

/** Font Awesome のアイコンに対応する文字コード ( UNICODE )。 */
@property (readonly, nonatomic) UniChar unicode;

+ (id)iconInfo:(UniChar)unicode;

@end
