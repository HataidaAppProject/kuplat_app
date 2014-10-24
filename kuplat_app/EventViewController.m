//
//  EventViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventViewController.h"
#import "EventDetailViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"EVENT";
    
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // テーブルに表示したいデータソースをセット
    self.menuItems = [NSMutableArray arrayWithCapacity:10];
    [self.menuItems addObject:@"イベント詳細"];
    [self.menuItems addObject:@"イベント詳細遷移テスト"];
    [self.menuItems addObject:@"イベント詳細"];
    
}


#pragma mark - UITableView DataSource

/**
 テーブルに表示するデータ件数を返します。（必須）
 @return NSInteger : データ件数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

/**
 テーブルに表示するセルを返します。（必須）
 @return UITableViewCell : テーブルセル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:_STCellId];
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_menuItems objectAtIndex:indexPath.row];
    //cell.textLabel.text = self.menuItems[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
        EventDetailViewController *con = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:con animated:YES];
    }
}


@end
