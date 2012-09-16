//
//  ABGridView.h
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012 Akabeko. All rights reserved. Distributed under the MIT license.
//
//  Original author: Andrey Tarantsov, ATArrayView https://github.com/andreyvit/SoloComponents-iOS/tree/master/ATArrayView
//

#import <Foundation/Foundation.h>

@protocol ABGridViewDelegate;

////////////////////////////////////////////////////////////////////////////////
/**
 * コントロールをグリッド形式で配置するコンテナです。
 */
@interface ABGridView : UIView

@property(nonatomic,   assign) id<ABGridViewDelegate> delegate;         //! デリゲート
@property(nonatomic,   assign) UIEdgeInsets           contentInsets;    //!
@property(nonatomic,   assign) CGSize                 itemSize;         //! グリッド配置するアイテムのサイズ
@property(nonatomic,   assign) CGFloat                minimumColumnGap; //! 最小のカラム間の余白

- (void)reloadData;
- (UIView *)viewForItemAtIndex:(NSUInteger)index;
- (UIView *)dequeueReusableItem;
- (CGRect)rectForItemAtIndex:(NSUInteger)index;

@end

////////////////////////////////////////////////////////////////////////////////
/**
 * ABGridView に関するデリゲートです。
 */
@protocol ABGridViewDelegate <NSObject>

@required
- (NSInteger)numberOfItemsInGridView:(ABGridView *)gridView;
- (UIView *)viewForItemInGridView:(ABGridView *)gridView atIndex:(NSInteger)index;

@optional
- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view;

@end
