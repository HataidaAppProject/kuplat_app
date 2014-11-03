//
//  EventViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景色 rgb=240,248,236
    [self setTitle:@"EVENT"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]];
    
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // カスタムセルを設定
    [self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    // セルの区切り線を消去
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    // テーブルに表示したいデータソースをセット
    self.menuItems = [NSMutableArray arrayWithCapacity:10];
    [self.menuItems addObject:@"イベントイベントイベントイベントイベントイベントイベント詳細"];
    [self.menuItems addObject:@"イベント詳細遷移テスト"];
    [self.menuItems addObject:@"京大カレー部 カレー販売"];
    [self.menuItems addObject:@"佐々木"];
    [self.menuItems addObject:@"潮野"];
    [self.menuItems addObject:@"テスト"];
    [self.menuItems addObject:@"てすと"];
    
}


#pragma mark - UITableView DataSource

/**
 テーブルに表示するデータ件数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

/**
 テーブルに表示するセルを返す
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.eventTitle setText:[self.menuItems objectAtIndex:indexPath.row]];
    [cell.eventImage setImage:[UIImage imageNamed:@"SampleTrendEvent"]];
    [cell.eventNumOfFavs setText:@"10名"];
    [cell.eventDate setText:@"2014.11.10"];
    [cell.eventPlace setText:@"京大"];
    [cell.eventCost setText:@"1,000円"];
    
    // アイテムの右端に矢印表示
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
        EventDetailViewController *con = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:con animated:YES];
    }
}

/**
 テーブルアイテムの上下左右に余白を挿入する
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableViewCell *iCell = (EventTableViewCell *) cell;
    iCell.insetH = 8.0;
    iCell.insetV = 4.0;
}

/**
 セルの高さを返す
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

@end
