//
//  MapViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () {
    GMSMapView *mapView;
}

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=92,124,181
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.361 green:0.486 blue:0.710 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初期の中心地点 -今は京大-
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.02625564504444
                                                            longitude:135.78081168761904
                                                                 zoom:15];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //ユーザの現在地の表示オプション
    mapView.myLocationEnabled = YES;
    //現在地ボタンの表示オプション
    mapView.settings.myLocationButton = YES;
    
    //地図を表示
    self.view = mapView;
    
    //マーカーの追加
    [self addMarkers];
}

- (void)addMarkers {
    
    //マーカーの色
    UIColor *eventMarkerColor = [UIColor colorWithRed:0.486 green:0.655 blue:0.376 alpha:1.0];
    UIColor *restaurantMarkerColor = [UIColor colorWithRed:0.816 green:0.510 blue:0.306 alpha:1.0];
    
    
    GMSMarker *event0 = [[GMSMarker alloc] init];
    event0.title = @"イベント×月○日";
    event0.snippet = @"時間：□時から☆時，主催：△";
    event0.position = CLLocationCoordinate2DMake(35.02625564504444, 135.78081168761904);
    event0.icon = [GMSMarker markerImageWithColor:eventMarkerColor];
    event0.map = mapView;
    
    GMSMarker *restaurant0 = [[GMSMarker alloc] init];
    restaurant0.title = @"ルネ";
    restaurant0.snippet = @"営業時間：□時から☆時";
    restaurant0.position = CLLocationCoordinate2DMake(35.027243, 135.778164);
    restaurant0.icon = [GMSMarker markerImageWithColor:restaurantMarkerColor];
    restaurant0.map = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
