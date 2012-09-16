//
//  AssetGroupViewController.h
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * AssetsLibrary 内のグループを列挙します。
 * 実装にあたり、以下の記事を参考にしました。
 *
 * iOS 4の新機能13選＆AssetsLibraryで作る画像ビューア（1/4） - ＠IT
 * http://www.atmarkit.co.jp/fsmart/articles/iphonesdk07/01.html
 */
@interface AssetGroupViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView* groupTableView;    //! グループ一覧
@property (nonatomic, assign) BOOL                  isViewModeUIImage; //! 表示モードが UIImage であることを示す値

@end
