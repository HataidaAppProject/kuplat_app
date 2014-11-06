//
//  RestaurantDetailViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=190,82,36
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    
    //タブ色の設定 遷移元のviewWillAppearを呼び出す
    //NSInteger index = [self.navigationController.viewControllers count];
    //UIViewController *parent = [self.navigationController.viewControllers objectAtIndex:index-2];
    //[parent viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"レストラン詳細"];
    
    // メニューを設置
    [self setDropdownMenu];
    
    // スクロールの中身となるViewの生成
    self.contentView = [[RestaurantDetailView alloc] initWithFrame:self.scrollView.bounds];
    // Constraintは自分で設定するのでNO
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Subviewとして追加
    [self.scrollView addSubview:self.contentView];

    // Constraintの設定
    UIScreen *sc = [UIScreen mainScreen];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0f
                                                                 constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0f
                                                                 constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0f
                                                                 constant:0]];
    /*
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0f
                                                                 constant:sc.applicationFrame.size.width]];
     */
    // クーポンの枠線
    [self.contentView.couponView.layer setBorderWidth:1.0f];
    [self.contentView.couponView.layer setBorderColor:[[UIColor colorWithRed:0.929 green:0.490 blue:0.192 alpha:1.0] CGColor]]; //rgb = 237,125,49
    
    // 画像
    [self.contentView.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView.imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:0.0
                                                                            constant:sc.applicationFrame.size.width - 16]];
    [self.contentView.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView.imageView setClipsToBounds:YES];
    [self.contentView.imageView setImage:self.restaurant.image];
    
    [self.contentView.restaurantName setText:self.restaurant.name];
    [self.contentView.restaurantType setText:self.restaurant.type];
    [self.contentView.restaurantScore setText:self.restaurant.score];
    
    [self setStar:self.contentView.star1 score:4.26 th:1.0];
    [self setStar:self.contentView.star2 score:4.26 th:2.0];
    [self setStar:self.contentView.star3 score:4.26 th:3.0];
    [self setStar:self.contentView.star4 score:4.26 th:4.0];
    [self setStar:self.contentView.star5 score:4.26 th:5.0];
    
    [self.contentView.restaurantCoupon setNumberOfLines:0];
    [self.contentView.restaurantCoupon setText:self.restaurant.coupon];
    
    [self.contentView.restaurantAddress setText:self.restaurant.address];
    
    //レビューは3行まで
    [self.contentView.review setNumberOfLines:3];
    [self.contentView.review setText:self.restaurant.review.text];
    
    [self.contentView.menuText setNumberOfLines:0];
    [self.contentView.menuText setText:[NSString stringWithFormat:@"%@  %lu円\n麻婆飯  700円\nセット  1,000円", self.restaurant.menu.menu, (long)self.restaurant.menu.price]];
    
    [self.contentView.informationText setNumberOfLines:0];
    [self.contentView.informationText setText:@"[電話番号] 075-xxxx-xxxx\n[営業時間] 11:00~22:00\n[定休日]  毎週火曜日\n[外部リンク]  http://www.hogehoge"];

    
    /*
    // 画像
    [self.contentView.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView.imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:0.0
                                                                            constant:sc.applicationFrame.size.width - 16]];
    [self.contentView.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView.imageView setClipsToBounds:YES];
    [self.contentView.imageView setImage:[UIImage imageNamed:@"second"]];
    
    [self.contentView.restaurantName setText:@"担々麺屋"];
    [self.contentView.restaurantType setText:@"ラーメン"];
    [self.contentView.restaurantScore setText:@"4.26"];
    
    [self setStar:self.contentView.star1 score:4.26 th:1.0];
    [self setStar:self.contentView.star2 score:4.26 th:2.0];
    [self setStar:self.contentView.star3 score:4.26 th:3.0];
    [self setStar:self.contentView.star4 score:4.26 th:4.0];
    [self setStar:self.contentView.star5 score:4.26 th:5.0];
    
    
    [self.contentView.review setNumberOfLines:0];
    [self.contentView.review setText:@"担々麺美味しい1辛ががおすすめ，麻婆飯も山椒がきいて美味しいよみたいな"];
    
    [self.contentView.menuText setNumberOfLines:0];
    [self.contentView.menuText setText:@"担々麺  720円\n麻婆飯  700円\nセット  1,000円"];
    
    [self.contentView.informationText setNumberOfLines:0];
    [self.contentView.informationText setText:@"[電話番号] 075-xxxx-xxxx\n[営業時間] 11:00~22:00\n[定休日]  毎週火曜日\n[外部リンク]  http://www.hogehoge"];
    */
     
    /**********************
     アイテムの非表示化(map)
     **********************/
    /*
     // viewの非表示化
     _contentView.mapView.hidden = NO;
     // viewの高さを0にする
     [_contentView.mapView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView.mapView
     attribute:NSLayoutAttributeHeight
     relatedBy:NSLayoutRelationEqual
     toItem:nil
     attribute:NSLayoutAttributeHeight
     multiplier:1.0f
     constant:0.0f]];
     // 直下viewとのマージンを0にする
     _contentView.mapViewBottomConstraint.constant = 0.0f;
     */
    
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

// 画面表示される時や画面回転した後に呼ばれる
- (void)viewDidLayoutSubviews
{
    [self.contentView setLayoutWidth:self.scrollView.frame.size.width];
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


@end
