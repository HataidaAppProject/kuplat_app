//
//  EventViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventViewController.h"

#define SCROLL_VIEW_TAG 10

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
    
    // ナビゲーションパーの非透過 -> オフセットが負になるのを防止
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // メニューを設置
    [self setDropdownMenu];
    
    /**********************************************************
     コンテンツのサイズを決める （オリジナルのフレームサイズじゃ駄目だった）
     **********************************************************/
    // 画面サイズに準拠してコンテンツサイズを決める
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
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
    [self.scrollView setTag:SCROLL_VIEW_TAG];
    
    
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
     リストの実装
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
    
    // データをサーバから取得
    [self loadData];
}

/**************************
 データソースのセット サーバから
 **************************/
- (void)loadData
{
    
    self.eventsItems1 = [NSMutableArray arrayWithCapacity:10];
    self.eventsItems2 = [NSMutableArray arrayWithCapacity:10];
    self.eventsItems3 = [NSMutableArray arrayWithCapacity:10];
    
    NSInteger i;
    for (i=0; i<10; i++) {
        
        EventItem *event = [[EventItem alloc] init];
        
        event.image = [UIImage imageNamed: @"SampleTrendEvent"];
        event.title = [NSString stringWithFormat:@"イベント%lu", (long)i];
        event.numOfFav = @"100";
        event.date = @"2014.11.11";
        event.cost = @"1,000円";
        event.address = @"吉田グラウンド";
        event.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
        event.information.sponsor = @"サークル";
        event.information.phoneNumber = @"090-xxxx-xxxx";
        event.information.url = @"http://hugaga";
        event.information.others = @"ほげほげ";
        
        [self.eventsItems1 addObject:event];
        [self.eventsItems2 addObject:event];
        [self.eventsItems3 addObject:event];
    }
}

///
// テーブルを選択した際のアクション
///
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 選択されたイベントを格納
    self.sendEvent = [[EventItem alloc] init];
    switch (tableView.tag) {
        case EventList1:
        {
            self.sendEvent = [self.eventsItems1 objectAtIndex:indexPath.row];
            break;
        }
        case EventList2:
        {
            self.sendEvent = [self.eventsItems2 objectAtIndex:indexPath.row];
            break;
        }
        case EventList3:
        {
            self.sendEvent = [self.eventsItems3 objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    // イベント詳細Viewへ遷移
    [self performSegueWithIdentifier:@"toEventDetailViewController" sender:self];

}

// ビューが遷移するタイミングで呼ばれる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"toEventDetailViewController"] ) {
        EventDetailViewController *eventDetailViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        eventDetailViewController.event = self.sendEvent;
    }
    
}

// テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger count;
    switch (tableView.tag) {
        case EventList1:
        {
            count = self.eventsItems1.count;
            break;
        }
        case EventList2:
        {
            count = self.eventsItems2.count;
            break;
        }
        case EventList3:
        {
            count = self.eventsItems3.count;
            break;
        }
        default:
            break;
    }
    
    return count;
}

// テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    EventItem *event;
    switch (tableView.tag) {
        case EventList1:
        {
            event = [self.eventsItems1 objectAtIndex:indexPath.row];
            break;
        }
        case EventList2:
        {
            event = [self.eventsItems2 objectAtIndex:indexPath.row];
            break;
        }
        case EventList3:
        {
            event = [self.eventsItems3 objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    [cell.eventImage setImage:event.image];
    [cell.eventTitle setText:event.title];
    [cell.eventNumOfFavs setText:event.numOfFav];
    [cell.eventDate setText:event.date];
    [cell.eventCost setText:event.cost];
    [cell.eventPlace setText:event.address];
    
    // セルの上下左右にマージンを追加
    cell.insetH = 0.0;
    cell.insetV = 4.0;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

// セルの高さを返す
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



///
// スクロール
///
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    
    
    switch (sender.tag) {
        case SCROLL_VIEW_TAG: //スクロールView
        {
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
            break;
        }
        case EventList1:
        {
            //一番下までスクロールしたかどうか
            BOOL leachToBottom = self.eventTableView1.contentOffset.y >= (self.eventTableView1.contentSize.height - self.eventTableView1.bounds.size.height);
            if (leachToBottom)
            {
                NSLog(@"リスト1の一番下");
                
                // 読み込み中だったら止める
            }
            break;
        }
        case EventList2:
        {
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*****************
 メニュー
 *****************/
- (void)setDropdownMenu
{
    self.dropdownMenuView = [[[NSBundle mainBundle] loadNibNamed:@"DropdownMenuView"
                                                           owner:self
                                                         options:nil] lastObject];
    self.dropdownMenuView.tabBarController = self.tabBarController;
    self.dropdownMenuView.navigationController = self.navigationController;
    [self.dropdownMenuView setDelegate:self];
    
    [self.dropdownMenuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *menuLayoutConstraints = [[NSMutableArray alloc] init];
    // 右端揃え
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dropdownMenuView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // View内に収まるようにする（念のため）
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dropdownMenuView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dropdownMenuView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // ボタンの1個の高さをNavigationBarの高さにする (縦横比はxibにて1:4)
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.dropdownMenuView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:self.navigationController.navigationBar.frame.size.height*MenuItemNum]];
    // 底辺と画面の上端
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.overlayView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.dropdownMenuView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [self.dropdownMenuView setHidden:YES];
    [self.view addSubview:self.dropdownMenuView];
    [self.view addConstraints:menuLayoutConstraints];
    
}

- (IBAction)tappedMenuButton:(id)sender
{
    if (self.dropdownMenuView.isMenuOpen) {
        [self hiddenOverlayView];
    } else {
        [self showOverlayView];
    }
    
    [self.dropdownMenuView tappedMenuButton];
}

- (void)dropdownMenuViewDidSelectedItem:(DropdownMenuView *)dropdownMenuView type:(DropdownMenuViewSelectedItemType)type
{
    [self hiddenOverlayView];
}

- (void)showOverlayView
{
    [self.dropdownMenuView setHidden:NO];
    [self.overlayView setHidden:NO];
    [self.overlayView setAlpha:0.0];
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.overlayView setAlpha:0.5];
                     }
                     completion:^(BOOL finished){
                     }];
    
    [UIView commitAnimations];
}

- (void)hiddenOverlayView
{
    [self.overlayView setAlpha:0.5];
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.overlayView setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         [self.dropdownMenuView setHidden:YES];
                         [self.overlayView setHidden:YES];
                     }];
    
    [UIView commitAnimations];
}


@end
