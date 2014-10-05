//
//  ABGridView.m
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012 Akabeko. All rights reserved. Distributed under the MIT license.
//
//  Original author: Andrey Tarantsov, ATArrayView https://github.com/andreyvit/SoloComponents-iOS/tree/master/ATArrayView
//

#import "ABGridView.h"

@interface ABGridView () <UIScrollViewDelegate>
{
    NSInteger    _itemCount;       //! アイテムの総数
    NSInteger    _colCount;        //! 列数
    NSInteger    _rowCount;        //! 行数
    CGFloat      _rowGap;          //! 行間
    CGFloat      _colGap;          //! 列間
    UIEdgeInsets _effectiveInsets; //!
}

@property(nonatomic, retain) UIScrollView* scrollView;    //! グリッド配置されるアイテムの表示領域
@property(nonatomic, retain) NSMutableSet* recycledItems; //! 再利用されるアイテム
@property(nonatomic, retain) NSMutableSet* visibleItems;  //! 表示されるアイテム

- (void)setup;
- (void)configureItems:(BOOL)updateExisting;
- (void)configureItem:(UIView *)item forIndex:(NSInteger)index;
- (void)recycleItem:(UIView *)item;

@end

@implementation ABGridView

#pragma mark - init/dealloc

/**
 * インスタンスを初期化します。
 *
 * @param frame コントロールの矩形情報。
 *
 * @return インスタンス。
 */
- (id)initWithFrame:(CGRect)frame
{
    if( ( self = [super initWithFrame:frame] ) )
    {
        [self setup];
    }

    return self;
}

/**
 * NIB が読み込まれた時に発生します。
 */
- (void)awakeFromNib
{
    [self setup];
}

/**
 * インスタンスを初期化します。
 */
-(void)setup
{
    self.visibleItems  = [[NSMutableSet alloc] init];
    self.recycledItems = [[NSMutableSet alloc] init];
	
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsVerticalScrollIndicator   = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces                        = YES;
    self.scrollView.delegate                       = self;
    [self addSubview:self.scrollView];

    _itemSize         = CGSizeMake( 70, 70 );
    _minimumColumnGap = 5;
}

#pragma mark - Data

/**
 * データを再読み込みします。
 */
- (void)reloadData
{
    _itemCount = [_delegate numberOfItemsInGridView:self];
	
    // recycle all items
    for( UIView *view in _visibleItems ) { [self recycleItem:view]; }
    [_visibleItems removeAllObjects];
	
    [self configureItems:NO];
    [self layoutSubviews];
}

#pragma mark - Item Views

/**
 * アイテムを取得します。
 *
 * @param index インデックス。
 *
 * @return アイテム。
 */
- (UIView *)viewForItemAtIndex:(NSUInteger)index
{
    for( UIView* item in _visibleItems )
    {
        if( item.tag == index ) { return item; }
    }

    return nil;
}

/**
 * アイテム設定を更新します。
 *
 * @param reconfigure アイテムを再設定する場合は YES。再配置のみを実行する場合は NO。
 */
- (void)configureItems:(BOOL)reconfigure
{
    // update content size if needed
    CGSize contentSize = CGSizeMake( self.bounds.size.width,
                                    _itemSize.height * _rowCount + _rowGap * (_rowCount - 1) + _effectiveInsets.top + _effectiveInsets.bottom );
    if( _scrollView.contentSize.width != contentSize.width || _scrollView.contentSize.height != contentSize.height )
    {
        _scrollView.contentSize = contentSize;
    }
	
    // calculate which items are visible
    const NSInteger firstItem = [self firstVisibleItemIndex];
    const NSInteger lastItem  = [self lastVisibleItemIndex];
	
    // recycle items that are no longer visible
    for( UIView *item in _visibleItems )
    {
        if( item.tag < firstItem || item.tag > lastItem )
        {
            [self recycleItem:item];
        }
    }
    [_visibleItems minusSet:_recycledItems];
	
    if( lastItem < 0 ) { return; }
	
    // add missing items
    for( NSInteger index = firstItem; index <= lastItem; index++ )
    {
        UIView* item = [self viewForItemAtIndex:index];
        if( item == nil )
        {
            item = [_delegate viewForItemInGridView:self atIndex:index];
            [_scrollView addSubview:item];
            [_visibleItems addObject:item];
        }
        else if( !reconfigure )
        {
            continue;
        }

        [self configureItem:item forIndex:index];
    }
}

/**
 * アイテム設定を更新します。
 *
 * @param item  アイテム
 * @param index インデックス。
 */
- (void)configureItem:(UIView *)item forIndex:(NSInteger)index
{
    item.tag   = index;
    item.frame = [self rectForItemAtIndex:index];

    if( [_delegate respondsToSelector:@selector(gridView:didSelectItemInGridView:)] )
    {
        // UIImageView などがアイテムでもタップ検出するため、常にユーザー操作を許可する
        item.userInteractionEnabled = YES;
		item.gestureRecognizers     = [NSArray arrayWithObjects:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector( tapItem: )], nil];
    }
    
    [item setNeedsDisplay]; // just in case
}

/**
 * アイテムがタップされた時に発生します。
 *
 * @param gestureRecognizer ジェスチャー情報。
 */
- (void)tapItem:(UIGestureRecognizer *)gestureRecognizer
{
	[_delegate gridView:self didSelectItemInGridView:gestureRecognizer.view];
}

#pragma mark - Layouting

/**
 * アイテムを再配置します。
 */
- (void)layoutSubviews
{
    BOOL boundsChanged = !CGRectEqualToRect( _scrollView.frame, self.bounds );
    if( boundsChanged )
    {
        // Strangely enough, if we do this assignment every time without the above
        // check, bouncing will behave incorrectly.
        _scrollView.frame = self.bounds;
    }
	
    _colCount = floorf( ( self.bounds.size.width - _contentInsets.left - _contentInsets.right ) / _itemSize.width );
	
    while( 1 )
    {
        _colGap = ( self.bounds.size.width - _contentInsets.left - _contentInsets.right - _itemSize.width * _colCount ) / ( _colCount + 1 );
        if( _colGap >= _minimumColumnGap ) { break; }

        --_colCount;
    };
	
    _rowCount = ( _itemCount + _colCount - 1 ) / _colCount;
    _rowGap   = _colGap;
	
    _effectiveInsets = UIEdgeInsetsMake( _contentInsets.top    + _rowGap,
                                         _contentInsets.left   + _colGap,
                                         _contentInsets.bottom + _rowGap,
                                         _contentInsets.right  + _colGap );
	
    [self configureItems:boundsChanged];
}

/**
 * 初めに表示されるアイテムのインデックスを算出します。
 *
 * @return インデックス。
 */
- (NSInteger)firstVisibleItemIndex
{
    const NSInteger firstRow = MAX( floorf( ( CGRectGetMinY( _scrollView.bounds ) - _effectiveInsets.top ) / (_itemSize.height + _rowGap ) ), 0 );
    return MIN( MAX( 0,firstRow ) * _colCount, _itemCount - 1 );
}

/**
 * 最後に表示されるアイテムのインデックスを算出します。
 *
 * @return インデックス。
 */
- (NSInteger)lastVisibleItemIndex
{
    const NSInteger lastRow = MIN( ceilf( ( CGRectGetMaxY( _scrollView.bounds ) - _effectiveInsets.top ) / ( _itemSize.height + _rowGap ) ), _rowCount - 1 );

    return MIN( ( lastRow + 1 ) * _colCount - 1, _itemCount - 1 );
}

/**
 * アイテムの矩形情報を算出します。
 *
 * @param index インデックス。
 *
 * @return 矩形情報。
 */
- (CGRect)rectForItemAtIndex:(NSUInteger)index
{
    const NSInteger row = index / _colCount;
    const NSInteger col = index % _colCount;
	
    return CGRectMake( _effectiveInsets.left + ( _itemSize.width  + _colGap ) * col,
                       _effectiveInsets.top  + ( _itemSize.height + _rowGap ) * row,
                       _itemSize.width,
                       _itemSize.height );
}

#pragma mark - Recycling

/**
 * 生成済みのアイテムを、再利用コレクションに追加します。
 *
 * @param item アイテム。
 */
- (void)recycleItem:(UIView *)item
{
    [_recycledItems addObject:item];
    [item removeFromSuperview];
}

/**
 * アイテムを再利用コレクションから取得します。
 *
 * @return アイテムが生成済みの場合は、そのインスタンス。それ以外は nil。
 */
- (UIView *)dequeueReusableItem
{
    UIView* result = [_recycledItems anyObject];
    if( result )
    {
        [_recycledItems removeObject:result];
    }

    return result;
}

#pragma mark - UIScrollViewDelegate methods

/**
 * スクロールされた時に発生します。
 *
 * @param scrollView 操作された UIScrollView。
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self configureItems:NO];
}

@end
