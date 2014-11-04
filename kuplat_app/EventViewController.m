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
    [self.view setBackgroundColor:[UIColor whiteColor]];

    /**********************************************************
     コンテンツのサイズを決める （オリジナルのフレームサイズじゃ駄目だった）
     **********************************************************/
    // 画面サイズに準拠してコンテンツサイズを決める
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
    //NSLog(@"ステータスバー領域を含まない画面サイズ：幅%f，高さ%f", cr.size.width, cr.size.height);
    self.originalFrameSize = CGSizeMake(cr.size.width,
                                        cr.size.height // ステータスパー除いた高さ
                                        - self.eventList1Button.frame.size.height // リスト選択ボタン
                                        - self.navigationController.navigationBar.frame.size.height // ナビゲーションバー
                                        - self.tabBarController.tabBar.frame.size.height); // タブ
    
    /************************************
     UIScrollView上に表示するコンテンツの準備
     ************************************/
    // UIScrollViewに表示するコンテンツViewを作成
    CGRect contentRect = CGRectMake(0, 0, self.originalFrameSize.width * 3, self.originalFrameSize.height);
    self.contentView = [[UIView alloc] initWithFrame:contentRect];
    // 3つのリストを作成
    self.eventTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * EventList1, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    self.eventTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * EventList2, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    self.eventTableView3 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * EventList3, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    // とりあえず色分けしとく
    [self.eventTableView1 setBackgroundColor:[UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]];
    [self.eventTableView2 setBackgroundColor:[UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]];
    [self.eventTableView3 setBackgroundColor:[UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]];
    // タグ
    [self.eventTableView1 setTag:EventList1];
    [self.eventTableView2 setTag:EventList2];
    [self.eventTableView3 setTag:EventList3];
    // 全部コンテンツViewに追加
    [self.contentView addSubview:self.eventTableView1];
    [self.contentView addSubview:self.eventTableView2];
    [self.contentView addSubview:self.eventTableView3];
    // スクロールViewにコンテンツViewを追加
    [self.scrollView addSubview:self.contentView];
    
    
    /*************************
     UIScrollViewの表示設定を行う
     *************************/
    // スクロールView上のコンテンツViewのサイズを指定
    [self.scrollView setContentSize:self.contentView.frame.size];
    // 初期表示するコンテンツViewの場所を指定する --> 一番左
    self.currentPage = EventList1;
    CGPoint initOffset = CGPointMake(self.originalFrameSize.width * self.currentPage, 0);
    [self.scrollView setContentOffset:initOffset];
    [self.scrollView setDelegate:self];
    // ページングモード
    [self.scrollView setPagingEnabled:YES];
    // スクロールバー消す
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    // コンテンツ境界でバウンドさせない
    [self.scrollView setBounces:NO];
    
    /****************************************
     リストの遷移を追うナビゲータ (ボタンの裏に実装)
     ****************************************/
    // リスト選択ボタンと同じ大きさのView
    CGRect listNaviRect = CGRectMake(self.originalFrameSize.width/3 * self.currentPage, self.eventList1Button.frame.origin.y, self.originalFrameSize.width/3, self.eventList1Button.frame.size.height);
    self.eventListNaviView = [[UIView alloc] initWithFrame:listNaviRect];
    // 色 restaurant [UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0]
    [self.eventListNaviView setBackgroundColor:[UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]];
    // 再背面のサブViewとして追加
    [self.view addSubview:self.eventListNaviView];
    [self.view sendSubviewToBack:self.eventListNaviView];
    // リスト選択ボタンは透明にする
    [self.eventList1Button setBackgroundColor:[UIColor clearColor]];
    [self.eventList2Button setBackgroundColor:[UIColor clearColor]];
    [self.eventList3Button setBackgroundColor:[UIColor clearColor]];
    
    
    /**************
     (未)リストの実装
     **************/
    // デリゲートメソッドをこのクラスで実装する
    [self.eventTableView1 setDelegate:self];
    [self.eventTableView2 setDelegate:self];
    [self.eventTableView3 setDelegate:self];
    [self.eventTableView1 setDataSource:self];
    [self.eventTableView2 setDataSource:self];
    [self.eventTableView3 setDataSource:self];
    // カスタムセルを設定
    [self.eventTableView1 registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.eventTableView2 registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.eventTableView3 registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    // セルの区切り線を消去
    [self.eventTableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.eventTableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.eventTableView3 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
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


///
// テーブルにアイテムを追加
///
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
        case EventList1:
        {
            
            break;
        }
        case EventList2:
        {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
            EventDetailViewController *con = [sb instantiateInitialViewController];
            [self.navigationController pushViewController:con animated:YES];
            break;
        }
        case EventList3:
        {
            
            break;
        }
        default:
            break;
    }
}

// テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

// テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    switch (tableView.tag) {
        case EventList1:
        {
            break;
        }
        case EventList2:
        {
            [cell.eventTitle setText:[self.menuItems objectAtIndex:indexPath.row]];
            [cell.eventImage setImage:[UIImage imageNamed:@"SampleTrendEvent"]];
            [cell.eventNumOfFavs setText:@"10名"];
            [cell.eventDate setText:@"2014.11.10"];
            [cell.eventPlace setText:@"京大"];
            [cell.eventCost setText:@"1,000円"];
            break;
        }
        case EventList3:
        {
            [cell.eventImage setImage:[UIImage imageNamed:@"SampleTrendEvent"]];
            [cell.eventNumOfFavs setText:@"100名"];
            [cell.eventDate setText:@"2014.11.100"];
            [cell.eventPlace setText:@"京大00"];
            [cell.eventCost setText:@"10,000円"];
            break;
        }
        default:
            break;
    }
    
    // アイテムの右端に矢印表示
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// テーブルアイテムの上下左右に余白を挿入する
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableViewCell *iCell = (EventTableViewCell *) cell;
    iCell.insetH = 8.0;
    iCell.insetV = 4.0;
}

// セルの高さを返す
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}



///
// スクロール
///
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅から，現在のページ番号を計算
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger page = (offset.x + self.originalFrameSize.width/2) / self.originalFrameSize.width;
    
    // リストNavigatorをスクロールと共に動かす
    CGRect rect = self.eventListNaviView.frame;
    rect.origin.x = offset.x / 3;
    self.eventListNaviView.frame = rect;
    
    // ページが変わったら
    if (self.currentPage != page) {
        self.currentPage = page;
        [self didWhenChangingList];
    }
}

- (IBAction)eventList1BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * EventList1;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)eventList2BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * EventList2;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)eventList3BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * EventList3;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

// リスト遷移時
- (void)didWhenChangingList {
    
    //NSLog(@"リスト遷移したったで");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
