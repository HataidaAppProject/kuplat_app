//
//  HomeViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=0,0,0
    [self.tabBarController.tabBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setTitle:@"KU PLAT"];
    
    // ナビゲーションパーの非透過 -> オフセットが負になるのを防止
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // メニューを設置
    [self setDropdownMenu];
    
    // データをサーバから読み込む
    [self loadData];
    
    /*****************
       ホーム画面上部
    *****************/
    //アスペクト比を保ったままサイズ調整
    [self.imgTop setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgTop setClipsToBounds:YES];
    [self.imgTop setImage:[UIImage imageNamed:@"KUPLATHOME.jpg"]];
    
    /*****************
       ホーム画面下部
    *****************/
    //タップを有効化
    [self.imgTrendEvent setUserInteractionEnabled:YES];
    [self.imgTrendRestaurant setUserInteractionEnabled:YES];
    //タグを設定
    [self.imgTrendEvent setTag:TrendEventImageTag];
    [self.imgTrendRestaurant setTag:TrendRestaurantImageTag];
    //アスペクト比を保ったままサイズ調整
    [self.imgTrendEvent setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgTrendEvent setClipsToBounds:YES];
    [self.imgTrendRestaurant setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgTrendRestaurant setClipsToBounds:YES];
    [self.imgTrendEvent setImage:self.trendEvent.image];
    [self.imgTrendRestaurant setImage:self.trendRestaurant.image];
    
    // タップアクション追加
    [self.imgTrendEvent addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapTrendEventAction:)]];
    [self.imgTrendRestaurant addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(tapTrendRestaurantAction:)]];
}

/*****************
 画像タップ時
 *****************/
-(void)tapTrendEventAction:sender
{
    // EVENT詳細Viewを生成
    EventDetailViewController *eventDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    eventDetailViewController.event = self.trendEvent;
    // EVENTタブを選択済にする
    UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
    [eventTabViewController popToRootViewControllerAnimated:NO];
    // EVENT詳細へ遷移
    [eventTabViewController pushViewController:eventDetailViewController animated:YES];
    self.tabBarController.selectedViewController = eventTabViewController;
    //[eventTabViewController.viewControllers[0] performSegueWithIdentifier:@"toEventDetailViewController" sender:self];
}
-(void)tapTrendRestaurantAction:sender
{
    // RESTAURANT詳細Viewを生成
    RestaurantDetailViewController *restaurantDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetailViewController"];
    restaurantDetailViewController.restaurantItem = self.trendRestaurant;
    // RESTAURANTタブを選択済にする
    UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
    [restaurantTabViewController popToRootViewControllerAnimated:NO];
    // RESTAURANT詳細へ遷移
    [restaurantTabViewController pushViewController:restaurantDetailViewController animated:YES];
    self.tabBarController.selectedViewController = restaurantTabViewController;
}


/*****************
 データの読み込み書込み
 *****************/
- (void)loadData
{
    /*****************
     トレンド情報をサーバから読み込む
     *****************/
    self.trendEvent = [[EventItem alloc] init];
    self.trendEvent.image = [UIImage imageNamed:@"SampleTrendEvent"];
    self.trendEvent.title = @"トレンドイベント";
    self.trendEvent.numOfFav = @"100";
    self.trendEvent.date = @"2014.11.11";
    self.trendEvent.cost = @"1,000円";
    self.trendEvent.address = @"吉田グラウンド";
    self.trendEvent.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge毎年恒例のなんちゃらかんちゃらfugafugahogehoge毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
    self.trendEvent.information.sponsor = @"サークル";
    self.trendEvent.information.phoneNumber = @"090-xxxx-xxxx";
    self.trendEvent.information.url = @"http://hugaga";
    self.trendEvent.information.others = @"ほげほげ";
    
    
    self.trendRestaurant = [[RestaurantItem alloc] init];
    self.trendRestaurant.image = [UIImage imageNamed:@"SampleTrendRestaurant"];
    self.trendRestaurant.name = @"トレンドRestaurant";
    self.trendRestaurant.type = @"カフェ";
    self.trendRestaurant.score = @"2.3";
    self.trendRestaurant.coupon = @"ランチタイムに限り，この画面提示で100円引き！";
    self.trendRestaurant.address = @"元田中";
    self.trendRestaurant.review.department = @"経済学部";
    self.trendRestaurant.review.grade = @"1";
    self.trendRestaurant.review.sex = @"男性";
    self.trendRestaurant.review.score = @"3.1";
    self.trendRestaurant.review.text = @"うまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうま";
    self.trendRestaurant.menu.menu = @"担々麺";
    self.trendRestaurant.menu.price = 1000;
    self.trendRestaurant.information.phoneNumber = @"075-xxxx-xxxx";
    self.trendRestaurant.information.businessHours = @"11:00~22:00";
    self.trendRestaurant.information.clodedDays = @"毎週月曜，年末年始";
    self.trendRestaurant.information.url = @"http://fugafuga";
    self.trendRestaurant.information.others = @"そのた";
}

-(void)writeData
{
    
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


- (IBAction)test:(id)sender {
    
    
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"ctfeedback@example.com"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
