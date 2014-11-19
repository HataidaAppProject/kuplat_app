//
//  ProfileViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "ProfileViewController.h"

#define FAV_EVENT_TABLE_TAG 1
#define FAV_RESTAURANT_TABLE_TAG 2
#define NUM_OF_TABLE_ITEMS 3

@interface ProfileViewController ()
@end

@implementation ProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=210,149,41
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // ナビゲーションパーの非透過
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    
    // 画像を読み込み，指定色でレンダリング
    UIImage *img = [UIImage imageNamed:@"profile"];
    [self.profileImg setContentMode:UIViewContentModeScaleAspectFill];
    [self.profileImg setClipsToBounds:YES];
    [self.view setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
    [self.profileImg setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    
    // favリスト(各3件ずつ)
    // デリゲートメソッドをこのクラスで実装する
    [self.favEventTableView setBackgroundColor:[UIColor clearColor]];
    [self.favRestaurantTableView setBackgroundColor:[UIColor clearColor]];
    [self.favEventTableView setTag:FAV_EVENT_TABLE_TAG];
    [self.favRestaurantTableView setTag:FAV_RESTAURANT_TABLE_TAG];
    [self.favEventTableView setDelegate:self];
    [self.favEventTableView setDataSource:self];
    [self.favRestaurantTableView setDelegate:self];
    [self.favRestaurantTableView setDataSource:self];
    // カスタムセルを設定
    [self.favEventTableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.favRestaurantTableView registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    // セルの区切り線を消去
    [self.favEventTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.favRestaurantTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    [self loadData];
    
    // メニューを設置
    [self setDropdownMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*****************
 データの読み込み
 *****************/
- (void)loadData
{
    self.eventsItems = [NSMutableArray arrayWithCapacity:NUM_OF_TABLE_ITEMS];
    self.restaurantsItems = [NSMutableArray arrayWithCapacity:NUM_OF_TABLE_ITEMS];
    
    NSInteger i;
    for (i=0; i<3; i++) {
        
        EventItem *event = [[EventItem alloc] init];
        event.image = [UIImage imageNamed: @"SampleTrendEvent"];
        event.title = [NSString stringWithFormat:@"お気に入りイベント%lu", (long)i];
        event.numOfFav = @"100";
        event.date = @"2014.11.11";
        event.cost = @"1,000円";
        event.address = @"吉田グラウンド";
        event.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
        event.information.sponsor = @"サークル";
        event.information.phoneNumber = @"090-xxxx-xxxx";
        event.information.url = @"http://hugaga";
        event.information.others = @"ほげほげ";
        [self.eventsItems addObject:event];
        
        RestaurantItem *restaurant = [[RestaurantItem alloc] init];
        restaurant.image = [UIImage imageNamed:@"SampleTrendRestaurant"];
        restaurant.name = [NSString stringWithFormat:@"お気に入りレストラン%lu", (long)i];
        restaurant.review.text = @"レビュー";
        restaurant.type = @"ラーメン";
        restaurant.score = [NSString stringWithFormat:@"%lu.0", (long)i%2];
        //restaurant.coupon = @"ランチタイムに限り，この画面提示で100円引き！";
        restaurant.address = @"元田中";
        restaurant.review.department = @"経済学部";
        restaurant.review.grade = @"1";
        restaurant.review.sex = @"男性";
        restaurant.review.score = @"3.1";
        restaurant.menu.menu = @"担々麺";
        restaurant.menu.price = 1000;
        restaurant.information.phoneNumber = @"075-xxxx-xxxx";
        restaurant.information.businessHours = @"11:00~22:00";
        restaurant.information.clodedDays = @"毎週月曜，年末年始";
        restaurant.information.url = @"http://fugafuga";
        [self.restaurantsItems addObject:restaurant];
    }
}



/*****************
 テーブル
 *****************/
// テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUM_OF_TABLE_ITEMS;
}

// テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
            case FAV_EVENT_TABLE_TAG:
        {
            EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            
            EventItem *event;
            event = [self.eventsItems objectAtIndex:indexPath.row];
            
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
            case FAV_RESTAURANT_TABLE_TAG:
        {
            
            RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[RestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            
            RestaurantItem *restaurant = [self.restaurantsItems objectAtIndex:indexPath.row];
            
            [cell.restaurantName setText:restaurant.name];
            [cell.restaurantImage setImage:restaurant.image];
            [cell.restaurantScore setText:restaurant.score];
            // レビューを3行まで表示
            [cell.restaurantReview setNumberOfLines:3];
            [cell.restaurantReview setText:restaurant.review.text];
            
            // 星をスコアに応じて色付け
            [self setStar:cell.restaurantStar1 score:[cell.restaurantScore.text floatValue] th:1.0];
            [self setStar:cell.restaurantStar2 score:[cell.restaurantScore.text floatValue] th:2.0];
            [self setStar:cell.restaurantStar3 score:[cell.restaurantScore.text floatValue] th:3.0];
            [self setStar:cell.restaurantStar4 score:[cell.restaurantScore.text floatValue] th:4.0];
            [self setStar:cell.restaurantStar5 score:[cell.restaurantScore.text floatValue] th:5.0];
            
            // セルの上下左右にマージンを追加
            cell.insetH = 0.0;
            cell.insetV = 4.0;
            
            return cell;
        }
        default:
            break;
    }
    UITableViewCell *cell;
    return cell;
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

// セルの高さを返す
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

// テーブルを選択した際のアクション
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
            case FAV_EVENT_TABLE_TAG:
        {
            self.sendEvent = [self.eventsItems objectAtIndex:indexPath.row];
            
            // EVENT詳細Viewを生成
            EventDetailViewController *eventDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
            eventDetailViewController.event = self.sendEvent;
            // EVENTタブを選択済にする
            UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
            [eventTabViewController popToRootViewControllerAnimated:NO];
            // EVENT詳細へ遷移
            [eventTabViewController pushViewController:eventDetailViewController animated:YES];
            self.tabBarController.selectedViewController = eventTabViewController;
            break;
        }
        case FAV_RESTAURANT_TABLE_TAG:
        {
            self.sendRestaurant = [self.restaurantsItems objectAtIndex:indexPath.row];
            
            // RESTAURANT詳細Viewを生成
            RestaurantDetailViewController *restaurantDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetailViewController"];
            restaurantDetailViewController.restaurantItem = self.sendRestaurant;
            // RESTAURANTタブを選択済にする
            UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
            [restaurantTabViewController popToRootViewControllerAnimated:NO];
            // RESTAURANT詳細へ遷移
            [restaurantTabViewController pushViewController:restaurantDetailViewController animated:YES];
            self.tabBarController.selectedViewController = restaurantTabViewController;
            break;
        }
        default:
            break;
    }
    
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
    [self.view bringSubviewToFront:self.dropdownMenuView];
}

- (IBAction)tappedMenuButton:(id)sender
{
    if (self.dropdownMenuView.isMenuOpen) {
        [self hiddenOverlayView];
    } else {
        [self showOverlayView];
    }
    
    // オフセットも渡してメニューバーが降りてくるようにする
    [self.dropdownMenuView tappedMenuButtonWithOffset:self.scrollView.contentOffset];
}

- (void)dropdownMenuViewDidSelectedItem:(DropdownMenuView *)dropdownMenuView type:(DropdownMenuViewSelectedItemType)type
{
    [self hiddenOverlayView];
}


- (void)showOverlayView
{
    // スクロール禁止にする
    [self.scrollView setScrollEnabled:NO];
    [self.overlayView setHidden:NO];
    [self.overlayView setAlpha:0.0];
    [self.dropdownMenuView setHidden:NO];
    
    [UIView animateWithDuration:0.3
                          delay:0.05
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
    
    [UIView animateWithDuration:0.3
                          delay:0.05
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.overlayView setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         [self.scrollView setScrollEnabled:YES];
                         [self.dropdownMenuView setHidden:YES];
                         [self.overlayView setHidden:YES];
                     }];
    
    [UIView commitAnimations];
}


@end
