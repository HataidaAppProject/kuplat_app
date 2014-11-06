//
//  EventDetailViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];

    //タブ色の設定 遷移元のviewWillAppearを呼び出す
    //NSInteger index = [self.navigationController.viewControllers count];
    //UIViewController *parent = [self.navigationController.viewControllers objectAtIndex:index-2];
    //[parent viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"イベント詳細"];
    
    // メニューを設置
    [self setDropdownMenu];
    
    // スクロールの中身となるViewの生成
    self.contentView = [[EventDetailView alloc] initWithFrame:self.scrollView.bounds];
    // Constraintは自分で設定するのでNO
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Subviewとして追加
    [self.scrollView addSubview:self.contentView];
    
    // Constraintの設定
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
    
    
    // 情報をViewに書き込む
    [self writeData];
    
}

- (void)writeData
{
    [self.contentView.eventTitle setText:self.event.title];
    //画像アスペクト比を保ったままサイズ調整
    UIScreen *sc = [UIScreen mainScreen];
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
    [self.contentView.imageView setImage:self.event.image];
    
    [self.contentView.eventNumOfFav setText:self.event.numOfFav];
    [self.contentView.eventDate setText:self.event.date];
    [self.contentView.eventCost setText:self.event.cost];
    [self.contentView.eventAddress setText:self.event.address];
    
    [self.contentView.aboutText setNumberOfLines:0];
    [self.contentView.aboutText setText:self.event.aboutText];
    
    [self.contentView.informationText setNumberOfLines:1];
    [self.contentView.informationText setText:self.event.information.sponsor];
    
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