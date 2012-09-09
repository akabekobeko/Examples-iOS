//
//  AssetGroupViewController.h
//  GridView
//
//  Created by Akabeko on 2012/09/09.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
/**
 * テスト方法を表します。
 */
typedef enum
{
	TestModeUIIMageView, //! UIImageView
	TestModeOriginalCell //! 独自のセル

} TestMode;

////////////////////////////////////////////////////////////////////////////////
/**
 * AssetsLibrary 内のグループを列挙します。
 * 実装にあたり、以下の記事を参考にしました。
 *
 * iOS 4の新機能13選＆AssetsLibraryで作る画像ビューア（1/4） - ＠IT
 * http://www.atmarkit.co.jp/fsmart/articles/iphonesdk07/01.html
 */
@interface AssetGroupViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView* groupTableView; //! グループ一覧
@property (nonatomic, assign) TestMode              testMode;       //! テスト方法

@end
