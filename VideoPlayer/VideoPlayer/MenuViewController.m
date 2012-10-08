//
//  ViewController.m
//  VideoPlayer
//
//  Created by Akabeko on 2012/09/29.
//  Copyright (c) 2012年 Akabeko. All rights reserved.
//

#import "MenuViewController.h"
#import "MoviePlayerViewController.h"
#import "AVPlayerViewController.h"
#import "AssetsViewController.h"

/**
 * 動画の再生方法を表します。
 */
typedef enum
{
    VideoModeNone,          //! 未定義
    VideoModeMPMoviePlayer, //! MPMoviePlayerController を利用
    VideoModeAVPlayer       //! AVPlayer を利用
    
} VideoMode;

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, AssetsViewControllerDelegate>

@property (nonatomic, assign) VideoMode videoMode; //! 動画の再生方法

@end

@implementation MenuViewController

#pragma mark - Lifecycle

/**
 * コントローラのインスタンスを生成します。
 *
 * @return インスタンス。
 */
+ (MenuViewController *)controller
{
    return [[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil] autorelease];
}

/**
 * インスタンスを破棄します。
 */
- (void)dealloc
{
    self.menuTableView = nil;

    [super dealloc];
}

#pragma mark - View

/**
 * 画面が読み込まれる時に発生します。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Video Player";

    self.menuTableView.dataSource = self;
    self.menuTableView.delegate   = self;
}

/**
 * 画面が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    self.menuTableView = nil;

    [super viewDidUnload];
}

#pragma mark - Table view data source

/**
 * テーブルのセクション数を取得します。
 *
 * @param tableView テーブル。
 *
 * @return セクション数。
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * テーブルのセクション内における、行数を取得します。
 *
 * @param tableView テーブル。
 * @param section   セクション。
 *
 * @return 行数。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

/**
 * テーブルのセルを取得します。
 *
 * @param tableView テーブル。
 * @param indexPath セルの位置。
 *
 * @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil )
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    switch( indexPath.row )
    {
    case 0:
        cell.textLabel.text = @"MPMoviePlayerController";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        break;
    
    case 1:
        cell.textLabel.text = @"AVPlayer";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        break;

    case 2:
        cell.textLabel.text = @"My video to album";
        cell.accessoryType = UITableViewCellAccessoryNone;
        break;

    default:
        break;
    }

    return cell;
}

#pragma mark - Table view delegate

/**
 * テーブル上の行が選択された時に発生します。
 *
 * @param tableView テーブル。
 * @param indexPath セルの位置。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row)
    {
    case 0: [self showMoviePlayer];               break;
    case 1: [self showAVPlayer];                  break;
    case 2: [self saveToAppDocumentVideoToAlbum]; break;
            
    default:
        break;
    }
}

/**
 * 画像の選択がキャンセルされた時に発生します。
 *
 * @param picker 画像選択コントロール。
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - AssetsViewControllerDelegate

/**
 * アセット情報の選択が完了した時に発生します。
 *
 * @param controller アセット情報選択コントローラー。
 * @param assetUrl   選択されたアセット情報の URL。
 */
- (void)selectAssetDidFinish:(AssetsViewController *)controller assetUrl:(NSURL *)assetUrl
{
    [self.navigationController dismissModalViewControllerAnimated:YES];

    switch( self.videoMode )
    {
    case VideoModeAVPlayer:
        self.navigationItem.backBarButtonItem = [self backButton];
        [self.navigationController pushViewController:[AVPlayerViewController controller:assetUrl] animated:YES];
        break;
  
    case VideoModeMPMoviePlayer:
        self.navigationItem.backBarButtonItem = [self backButton];
        [self.navigationController pushViewController:[MoviePlayerViewController controller:assetUrl] animated:YES];
        break;
        
    default:
        break;
    }
    
}

#pragma mark - Private

/**
 * 戻るボタンを取得します。
 *
 * @return 戻るボタン。
 */
- (UIBarButtonItem *)backButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
}

/**
 * MPMoviePlayerController による動画再生テスト画面を表示します。
 */
- (void)showMoviePlayer
{
    self.videoMode = VideoModeMPMoviePlayer;
    
    UIViewController* dialog = [AssetsViewController controller:self];
    [self.navigationController presentModalViewController:dialog animated:YES];
}

/**
 * AVPlayer による動画再生テスト画面を表示します。
 */
- (void)showAVPlayer
{
    self.videoMode = VideoModeAVPlayer;

    UIViewController* dialog = [AssetsViewController controller:self];
    [self.navigationController presentModalViewController:dialog animated:YES];
}

/**
 * アプリケーションのドキュメント フォルダ内に保存されている動画をアルバムに保存します。
 *
 * iOS シミュレーターでテストする場合、Finder からアプリケーションのドキュメント フォルダに動画を保存しておき、
 * このメソッドでアルバムに保存することで、動画転送の代替となります。
 */
- (void)saveToAppDocumentVideoToAlbum
{
	NSArray*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
	NSString* dir   = [paths objectAtIndex:0];
    NSArray*  files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];

    NSInteger savedCount = 0;
    for( NSString* file in files )
    {
        NSString* extention = [file pathExtension];
        if( [extention isEqualToString:@"mov"] ||
            [extention isEqualToString:@"mp4"] ||
            [extention isEqualToString:@"m4v"])
        {
            NSString* path = [dir stringByAppendingPathComponent:file];
            UISaveVideoAtPathToSavedPhotosAlbum( path, nil, nil, nil );
            savedCount++;
        }
    }

    NSString* message = ( savedCount == 0 ? @"Video file not found." : [NSString stringWithFormat:@"Saved the %d video files.", savedCount] );
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Information"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"OK", nil] autorelease];
    [alert show];
}

@end
