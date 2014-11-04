//
//  RestaurantViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RestaurantViewController.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=190,82,36
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景色 rgb=240,248,236
    [self setTitle:@"RESTAURANT"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**********************************************************
     コンテンツのサイズを決める （オリジナルのフレームサイズじゃ駄目だった）
     **********************************************************/
    // 画面サイズに準拠してコンテンツサイズを決める
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
    //NSLog(@"ステータスバー領域を含まない画面サイズ：幅%f，高さ%f", cr.size.width, cr.size.height);
    self.originalFrameSize = CGSizeMake(cr.size.width,
                                        cr.size.height // ステータスパー除いた高さ
                                        - self.restaurantList1Button.frame.size.height // リスト選択ボタン
                                        - self.navigationController.navigationBar.frame.size.height // ナビゲーションバー
                                        - self.tabBarController.tabBar.frame.size.height); // タブ
    
    /************************************
     UIScrollView上に表示するコンテンツの準備
     ************************************/
    // UIScrollViewに表示するコンテンツViewを作成
    CGRect contentRect = CGRectMake(0, 0, self.originalFrameSize.width * 3, self.originalFrameSize.height);
    self.contentView = [[UIView alloc] initWithFrame:contentRect];
    // 3つのリストを作成
    self.restaurantTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList1, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    self.restaurantTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList2, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    self.restaurantTableView3 = [[UITableView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList3, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    // とりあえず色分けしとく
    [self.restaurantTableView1 setBackgroundColor:[UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0]];
    [self.restaurantTableView2 setBackgroundColor:[UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0]];
    [self.restaurantTableView3 setBackgroundColor:[UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0]];
    // タグ
    [self.restaurantTableView1 setTag:RestaurantList1];
    [self.restaurantTableView2 setTag:RestaurantList2];
    [self.restaurantTableView3 setTag:RestaurantList3];
    // 全部コンテンツViewに追加
    [self.contentView addSubview:self.restaurantTableView1];
    [self.contentView addSubview:self.restaurantTableView2];
    [self.contentView addSubview:self.restaurantTableView3];
    // スクロールViewにコンテンツViewを追加
    [self.scrollView addSubview:self.contentView];
    
    
    /*************************
     UIScrollViewの表示設定を行う
     *************************/
    // スクロールView上のコンテンツViewのサイズを指定
    [self.scrollView setContentSize:self.contentView.frame.size];
    // 初期表示するコンテンツViewの場所を指定する --> 一番左
    self.currentPage = RestaurantList1;
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
    CGRect listNaviRect = CGRectMake(self.originalFrameSize.width/3 * self.currentPage, self.restaurantList1Button.frame.origin.y, self.originalFrameSize.width/3, self.restaurantList1Button.frame.size.height);
    self.restaurantListNaviView = [[UIView alloc] initWithFrame:listNaviRect];
    // 色 event [UIColor colorWithRed:0.941 green:0.973 blue:0.925 alpha:1.0]
    [self.restaurantListNaviView setBackgroundColor:[UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0]];
    // 再背面のサブViewとして追加
    [self.view addSubview:self.restaurantListNaviView];
    [self.view sendSubviewToBack:self.restaurantListNaviView];
    // リスト選択ボタンは透明にする
    [self.restaurantList1Button setBackgroundColor:[UIColor clearColor]];
    [self.restaurantList2Button setBackgroundColor:[UIColor clearColor]];
    [self.restaurantList3Button setBackgroundColor:[UIColor clearColor]];
    
    
    /**************
     (未)リストの実装
     **************/
    // デリゲートメソッドをこのクラスで実装する
    [self.restaurantTableView1 setDelegate:self];
    [self.restaurantTableView2 setDelegate:self];
    [self.restaurantTableView3 setDelegate:self];
    [self.restaurantTableView1 setDataSource:self];
    [self.restaurantTableView2 setDataSource:self];
    [self.restaurantTableView3 setDataSource:self];
    // カスタムセルを設定
    [self.restaurantTableView1 registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.restaurantTableView2 registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.restaurantTableView3 registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    // セルの区切り線を消去
    [self.restaurantTableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.restaurantTableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.restaurantTableView3 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
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
        case RestaurantList1:
        {
            
            break;
        }
        case RestaurantList2:
        {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
            EventDetailViewController *con = [sb instantiateInitialViewController];
            [self.navigationController pushViewController:con animated:YES];
            break;
        }
        case RestaurantList3:
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
    
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // レビューを3行まで表示
    [cell.restaurantReview setNumberOfLines:3];
    
    switch (tableView.tag) {
        case RestaurantList1:
        {
            break;
        }
        case RestaurantList2:
        {
            [cell.restaurantName setText:[self.menuItems objectAtIndex:indexPath.row]];
            [cell.restaurantImage setImage:[UIImage imageNamed:@"SampleTrendrestaurant"]];
            [cell.restaurantScore setText:@"5.0"];
            [cell.restaurantReview setText:@"うまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうま"];
            break;
        }
        case RestaurantList3:
        {
            [cell.restaurantImage setImage:[UIImage imageNamed:@"SampleTrendrestaurant"]];
            [cell.restaurantScore setText:@"1.0"];
            [cell.restaurantReview setText:@"まず"];
            break;
        }
        default:
            break;
    }
    // 星をスコアに応じて色付け
    [self setStar:cell.restaurantStar1 score:[cell.restaurantScore.text floatValue] th:1.0];
    [self setStar:cell.restaurantStar2 score:[cell.restaurantScore.text floatValue] th:2.0];
    [self setStar:cell.restaurantStar3 score:[cell.restaurantScore.text floatValue] th:3.0];
    [self setStar:cell.restaurantStar4 score:[cell.restaurantScore.text floatValue] th:4.0];
    [self setStar:cell.restaurantStar5 score:[cell.restaurantScore.text floatValue] th:5.0];
    
    // セルの上下左右にマージンを追加
    cell.insetH = 8.0;
    cell.insetV = 4.0;
    
    // アイテムの右端に矢印表示
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// セルの高さを返す
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

// スコアから星の表示を得る
- (void)setStar:(UILabel *)star score:(float)score th:(float)val
{
    if (score < val) {
        [star setText:@"☆"];
        [star setTextColor:[UIColor blackColor]];
    }
    else
    {
        // 黄色の星 rgb = 249,192,50
        [star setText:@"★"];
        [star setTextColor:[UIColor colorWithRed:0.976 green:0.753 blue:0.196 alpha:1.0]];
    }
}

///
// スクロール
///
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅から，現在のページ番号を計算
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger page = (offset.x + self.originalFrameSize.width/2) / self.originalFrameSize.width;
    
    // リストNavigatorをスクロールと共に動かす
    CGRect rect = self.restaurantListNaviView.frame;
    rect.origin.x = offset.x / 3;
    self.restaurantListNaviView.frame = rect;
    
    // ページが変わったら
    if (self.currentPage != page) {
        self.currentPage = page;
        [self didWhenChangingList];
    }
}

- (IBAction)restaurantList1BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList1;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)restaurantList2BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList2;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)restaurantList3BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList3;
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
