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
    
    
    [self setTitle:@"EVENT詳細"];
    
    // 情報をViewに書き込む
    [self writeData];
    
    // メニューを設置
    [self setDropdownMenu];
    
}


- (void)writeData
{
    [self.eventTitle setText:self.event.title];
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setClipsToBounds:YES];
    [self.imageView setImage:self.event.image];
    
    [self.eventNumOfFav setText:self.event.numOfFav];
    [self.eventDate setText:self.event.date];
    [self.eventCost setText:self.event.cost];
    [self.eventAddress setText:self.event.address];
    
    [self.eventAbout setNumberOfLines:0];
    [self.eventAbout setText:self.event.aboutText];
    
    [self.eventInformation setNumberOfLines:1];
    [self.eventInformation setText:self.event.information.sponsor];
    
    /**********************
     アイテムの非表示化(map)
     **********************/
    /*
     // viewの非表示化
     _mapView.hidden = NO;
     // viewの高さを0にする
     [_mapView addConstraint:[NSLayoutConstraint constraintWithItem:_mapView
     attribute:NSLayoutAttributeHeight
     relatedBy:NSLayoutRelationEqual
     toItem:nil
     attribute:NSLayoutAttributeHeight
     multiplier:1.0f
     constant:0.0f]];
     // 直下viewとのマージンを0にする
     _mapViewBottomConstraint.constant = 0.0f;
     */
}

// 画面表示される時や画面回転した後に呼ばれる
- (void)viewDidLayoutSubviews
{
    //[self.view setLayoutWidth:self.scrollView.frame.size.width];
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