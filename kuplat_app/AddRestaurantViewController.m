//
//  AddRestaurantViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "AddRestaurantViewController.h"

@implementation AddRestaurantViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=190,82,36
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
}

- (void)viewDidLoad
{
    
    
    [self displayMap];
    
    self.typeSelectionField.dropList = @[@"カフェ", @"ラーメン", @"レストラン", @"パン・スイーツ", @"居酒屋・バー" ];
    self.photoTypeSelectionField.dropList = @[@"店舗", @"フード", @"メニュー", @"その他"];
}

- (void)displayMap
{
    // 初期の中心地点 -これは京大でいいよね-
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.02625564504444
                                                            longitude:135.78081168761904
                                                                 zoom:15];
    self.mapView = [GMSMapView mapWithFrame:CGRectNull camera:camera];
    self.mapView.delegate = self;
    
    //ユーザの現在地の表示オプション
    //self.mapView.myLocationEnabled = YES;
    
    //現在地ボタンの表示オプション
    //self.mapView.settings.myLocationButton = YES;
    
    [self.mapSuperView addSubview:self.mapView];
    /*
    [self.mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mapView addConstraint:[NSLayoutConstraint constraintWithItem:self.mapView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.mapSuperView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    */

}

@end
