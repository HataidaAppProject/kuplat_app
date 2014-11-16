//
//  ProfileViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "ProfileViewController.h"

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
    
    // サーバから一つ呼び出し
    [self loadData];
    [self writeData];
    
    //タップを有効化
    [self.favEventView setUserInteractionEnabled:YES];
    [self.favRestaurantView setUserInteractionEnabled:YES];
    //タグを設定
    [self.favEventView setTag:FavoriteEventCellTag];
    [self.favRestaurantView setTag:FavoriteRestaurantCellTag];
    // タップアクション追加
    [self.favEventView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapFavEventAction:)]];
    [self.favRestaurantView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(tapFavRestaurantAction:)]];
    
    // メニューを設置
    [self setDropdownMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*****************
 データの読み込み書込み
 *****************/
- (void)loadData
{
    /*****************
     トレンド情報をサーバから読み込む
     *****************/
    self.favEvent = [[EventItem alloc] init];
    self.favEvent.image = [UIImage imageNamed: @"SampleTrendEvent"];
    self.favEvent.title = @"お気に入りイベント";
    self.favEvent.numOfFav = @"100";
    self.favEvent.date = @"2014.11.11";
    self.favEvent.cost = @"1,000円";
    self.favEvent.address = @"吉田グラウンド";
    self.favEvent.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge毎年恒例のなんちゃらかんちゃらfugafugahogehoge毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
    self.favEvent.information.sponsor = @"サークル";
    self.favEvent.information.phoneNumber = @"090-xxxx-xxxx";
    self.favEvent.information.url = @"http://hugaga";
    self.favEvent.information.others = @"ほげほげ";
    
    
    self.favRestaurant = [[RestaurantItem alloc] init];
    self.favRestaurant.image = [UIImage imageNamed:@"SampleTrendRestaurant"];
    self.favRestaurant.name = @"お気に入りRestaurant";
    self.favRestaurant.type = @"カフェ";
    self.favRestaurant.score = @"2.3";
    self.favRestaurant.coupon = @"ランチタイムに限り，この画面提示で100円引き！";
    self.favRestaurant.address = @"元田中";
    self.favRestaurant.review.department = @"経済学部";
    self.favRestaurant.review.grade = @"1";
    self.favRestaurant.review.sex = @"男性";
    self.favRestaurant.review.score = @"3.1";
    self.favRestaurant.review.text = @"うまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうま";
    self.favRestaurant.menu.menu = @"担々麺";
    self.favRestaurant.menu.price = 1000;
    self.favRestaurant.information.phoneNumber = @"075-xxxx-xxxx";
    self.favRestaurant.information.businessHours = @"11:00~22:00";
    self.favRestaurant.information.clodedDays = @"毎週月曜，年末年始";
    self.favRestaurant.information.url = @"http://fugafuga";
    self.favRestaurant.information.others = @"そのた";
}

- (void)writeData
{
    [self.eventImage setImage:self.favEvent.image];
    [self.eventTitle setText:self.favEvent.title];
    [self.eventNumOfFavs setText:self.favEvent.numOfFav];
    [self.eventDate setText:self.favEvent.date];
    [self.eventCost setText:self.favEvent.cost];
    [self.eventPlace setText:self.favEvent.address];
    
    [self.restaurantName setText:self.favRestaurant.name];
    [self.restaurantImage setImage:self.favRestaurant.image];
    [self.restaurantScore setText:self.favRestaurant.score];
    // レビューを3行まで表示
    [self.restaurantReview setNumberOfLines:3];
    [self.restaurantReview setText:self.favRestaurant.review.text];
    
    // 星をスコアに応じて色付け
    [self setStar:self.restaurantStar1 score:[self.restaurantScore.text floatValue] th:1.0];
    [self setStar:self.restaurantStar2 score:[self.restaurantScore.text floatValue] th:2.0];
    [self setStar:self.restaurantStar3 score:[self.restaurantScore.text floatValue] th:3.0];
    [self setStar:self.restaurantStar4 score:[self.restaurantScore.text floatValue] th:4.0];
    [self setStar:self.restaurantStar5 score:[self.restaurantScore.text floatValue] th:5.0];

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


    
/*****************
  fav画面タップ時
 *****************/
-(void)tapFavEventAction:sender
{
    
    // EVENT詳細Viewを生成
    EventDetailViewController *eventDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    eventDetailViewController.event = self.favEvent;
    // EVENTタブを選択済にする
    UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
    [eventTabViewController popToRootViewControllerAnimated:NO];
    // EVENT詳細へ遷移
    [eventTabViewController pushViewController:eventDetailViewController animated:YES];
    self.tabBarController.selectedViewController = eventTabViewController;
    //[eventTabViewController.viewControllers[0] performSegueWithIdentifier:@"toEventDetailViewController" sender:self];
}
-(void)tapFavRestaurantAction:sender
{
    
    // RESTAURANT詳細Viewを生成
    RestaurantDetailViewController *restaurantDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetailViewController"];
    restaurantDetailViewController.restaurant = self.favRestaurant;
    // RESTAURANTタブを選択済にする
    UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
    [restaurantTabViewController popToRootViewControllerAnimated:NO];
    // RESTAURANT詳細へ遷移
    [restaurantTabViewController pushViewController:restaurantDetailViewController animated:YES];
    self.tabBarController.selectedViewController = restaurantTabViewController;
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
