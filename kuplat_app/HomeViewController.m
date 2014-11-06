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
    
    // メニューを設置
    [self setDropdownMenu];
    
    // データをサーバから読み込む
    [self loadData];
    
    /*****************
       ホーム画面上部
    *****************/
    
    
    
    /*****************
       ホーム画面下部
    *****************/
    //タップを有効化
    [self.imgTrendEvent setUserInteractionEnabled:YES];
    [self.imgTrendRestaurant setUserInteractionEnabled:YES];
    //タグを設定
    [self.imgTrendEvent setTag:1];
    [self.imgTrendRestaurant setTag:2];
    //アスペクト比を保ったままサイズ調整
    [self.imgTrendEvent setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgTrendEvent setClipsToBounds:YES];
    [self.imgTrendRestaurant setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgTrendRestaurant setClipsToBounds:YES];
    [self.imgTrendEvent setImage:self.trendEvent.image];
    [self.imgTrendRestaurant setImage:self.trendRestaurant.image];
}

/*****************
 画像をタップした際の遷移
 *****************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 1:
        {
            // イベント詳細へ遷移
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
            EventDetailViewController *eventDetailViewController = [storyboard instantiateInitialViewController];
            eventDetailViewController.event = self.trendEvent;

            // EVENTタブのViewControllerを取得する
            UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
            // EVENTタブを選択済みにする
            self.tabBarController.selectedViewController = eventTabViewController;
            // UINavigationControllerに追加済みのViewを一旦取り除く
            [eventTabViewController popToRootViewControllerAnimated:NO];
            // EVENTViewの画面遷移処理を呼び出す
            [eventTabViewController pushViewController:eventDetailViewController animated:YES];
            NSLog(@"ここから遷移");
            break;
        }
        case 2:
        {
            // レストラン詳細へ遷移
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RestaurantDetailViewController" bundle:nil];
            RestaurantDetailViewController *restaurantDetailViewController = [storyboard instantiateInitialViewController];
            // トレンドレストランの情報を渡す
            restaurantDetailViewController.restaurant = self.trendRestaurant;
            
            // RESTAURANTタブのViewControllerを取得する
            UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
            // UINavigationControllerに追加済みのViewを一旦取り除く
            [restaurantTabViewController popToRootViewControllerAnimated:NO];
            // RESTAURANTタブを選択済みにする
            self.tabBarController.selectedViewController = restaurantTabViewController;
            // RESTAURANTViewの画面遷移処理を呼び出す
            [restaurantTabViewController pushViewController:restaurantDetailViewController animated:YES];
            
            break;
        }
        default:
            break;
    }
    
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
    self.trendEvent.image = [UIImage imageNamed: @"SampleTrendEvent"];
    self.trendEvent.title = @"トレンドイベント";
    self.trendEvent.numOfFav = @"100";
    self.trendEvent.date = @"2014.11.11";
    self.trendEvent.cost = @"1,000円";
    self.trendEvent.address = @"吉田グラウンド";
    self.trendEvent.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
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
    self.menuView = [[[NSBundle mainBundle] loadNibNamed:@"MenuView"
                                                   owner:self
                                                 options:nil] lastObject];
    [self.menuView setDelegate:self];
    
    [self.menuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *menuLayoutConstraints = [[NSMutableArray alloc] init];
    // 右端揃え
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // View内に収まるようにする（念のため）
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // ボタンの1個の高さをNavigationBarの高さにする (縦横比はxibにて1:4)
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
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
                                                                     toItem:self.menuView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    
    [self.view addSubview:self.menuView];
    [self.view addConstraints:menuLayoutConstraints];

}

- (IBAction)tappedMenuButton:(id)sender
{
    if (self.menuView.isMenuOpen) {
        [self hiddenOverlayView];
    } else {
        [self showOverlayView];
    }
    
    [self.menuView tappedMenuButton];
}

- (void)menuViewDidSelectedItem:(MenuView *)menuView type:(MenuViewSelectedItemType)type
{
    [self hiddenOverlayView];
}

- (void)showOverlayView
{
    self.overlayView.hidden = NO;
    self.overlayView.alpha = 0.0;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.overlayView.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                     }];
    
    [UIView commitAnimations];
}

- (void)hiddenOverlayView
{
    self.overlayView.alpha = 0.5;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.overlayView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.overlayView.hidden = YES;
                     }];
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
