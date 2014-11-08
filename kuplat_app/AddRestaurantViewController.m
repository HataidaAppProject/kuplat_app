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
    [super viewDidLoad];
    
    [self displayMap];
    
    self.typeSelectionField.dropList = @[@"カフェ", @"ラーメン", @"レストラン", @"パン・スイーツ", @"居酒屋・バー" ];
    self.photoTypeSelectionField.dropList = @[@"店舗", @"フード", @"メニュー", @"その他"];
}

- (void)displayMap
{
    // 初期の中心地点 -これは京大でいいよね-
    CLLocationCoordinate2D initLocation = CLLocationCoordinate2DMake(35.02625564504444, 135.78081168761904);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:initLocation.latitude
                                                            longitude:initLocation.longitude
                                                                 zoom:15];
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
    CGRect mapRect = CGRectMake(0.0, 0.0, cr.size.width - 16.0 * 2, (cr.size.width - 16.0 * 2) * 3 /4);
    self.mapView = [GMSMapView mapWithFrame:mapRect camera:camera];
    
    [self.mapView setDelegate:self];
    [self.mapView.settings setRotateGestures:NO];
     
    [self.mapSuperView addSubview:self.mapView];
     
    
    self.marker = [[GMSMarker alloc] init];
    [self.marker setPosition:initLocation];
    [self.marker setMap:self.mapView];
    
    
}

// タップした場所を中心にする
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                                      longitude:coordinate.longitude
                                                                           zoom:self.mapView.camera.zoom]];
}

// マーカーを常に真ん中に表示する
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    [self.marker setPosition:position.target];
}



- (IBAction)pusuAddRestaurantBotton:(id)sender {
}
@end
