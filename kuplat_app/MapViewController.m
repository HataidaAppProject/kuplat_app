//
//  MapViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () {
}

@end

@implementation MapViewController


- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=92,124,181
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.361 green:0.486 blue:0.710 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.361 green:0.486 blue:0.710 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初期の中心地点 -今は京大-
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.02625564504444
                                                            longitude:135.78081168761904
                                                                 zoom:15];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.delegate = self;
    
    //ユーザの現在地の表示オプション
    self.mapView.myLocationEnabled = YES;
    
    //現在地ボタンの表示オプション
    self.mapView.settings.myLocationButton = YES;
    
    //DropdownMenuが見えるように最下層のサブビューに追加
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    
    // 読み込み
    [self loadData];
    
    //マーカーの追加
    [self addMarkers];
    
    // メニューを設置
    [self setDropdownMenu];
}

- (void)loadData
{
    self.eventsItems = [NSMutableArray arrayWithCapacity:10];
    self.restaurantsItems = [NSMutableArray arrayWithCapacity:10];
    
    
    EventItem *event = [[EventItem alloc] init];
    event.image = [UIImage imageNamed: @"SampleTrendEvent"];
    event.title = [NSString stringWithFormat:@"map上で表示するイベント"];
    event.numOfFav = @"1";
    event.date = @"2014.11.11";
    event.cost = @"10,000円";
    event.address = @"時計台";
    event.aboutText = @"毎年恒例のなんちゃらかんちゃらfugafugahogehoge";
    event.information.sponsor = @"○×サークル";
    event.information.phoneNumber = @"090-xxxx-xxxx";
    event.information.url = @"http://hugaga";
    event.information.others = @"ほげほげ";
    event.latitude = 35.02625564504444;
    event.longitude = 135.78081168761904;
    [self.eventsItems addObject:event];
    
    
    
    RestaurantItem *restaurant = [[RestaurantItem alloc] init];
    restaurant.image = [UIImage imageNamed:@"SampleTrendRestaurant"];
    restaurant.name = @"[from map]レストランレストランレストランレストランレストラン詳細";
    restaurant.type = @"ラーメン";
    restaurant.score = @"4.3";
    restaurant.coupon = @"ランチタイムに限り，この画面提示で100円引き！";
    restaurant.address = @"元田中";
    restaurant.review.department = @"経済学部";
    restaurant.review.grade = @"1";
    restaurant.review.sex = @"男性";
    restaurant.review.score = @"3.1";
    restaurant.review.text = @"うまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうまうま";
    restaurant.menu.menu = @"担々麺";
    restaurant.menu.price = 1000;
    restaurant.information.phoneNumber = @"075-xxxx-xxxx";
    restaurant.information.businessHours = @"11:00~22:00";
    restaurant.information.clodedDays = @"毎週月曜，年末年始";
    restaurant.information.url = @"http://fugafuga";
    restaurant.latitude = 35.027243;
    restaurant.longitude = 135.778164;
    [self.restaurantsItems addObject:restaurant];
    
}

- (void)addMarkers
{
    
    //マーカーの色
    UIColor *eventMarkerColor = [UIColor colorWithRed:0.486 green:0.655 blue:0.376 alpha:1.0];
    UIColor *restaurantMarkerColor = [UIColor colorWithRed:0.816 green:0.510 blue:0.306 alpha:1.0];
    
    for (EventItem *event in self.eventsItems) {
            GMSMarker *eventMarker = [[GMSMarker alloc] init];
            eventMarker.title = event.title;
            eventMarker.snippet = event.address;
            eventMarker.position = CLLocationCoordinate2DMake(event.latitude, event.longitude);
            eventMarker.icon = [GMSMarker markerImageWithColor:eventMarkerColor];
            eventMarker.map = self.mapView;
            eventMarker.userData = event;
    }
    
    for (RestaurantItem *restaurant in self.restaurantsItems) {
            GMSMarker *restaurantMarker = [[GMSMarker alloc] init];
            restaurantMarker.title = restaurant.name;
            restaurantMarker.snippet = restaurant.address;
            restaurantMarker.position = CLLocationCoordinate2DMake(restaurant.latitude, restaurant.longitude);
            restaurantMarker.icon = [GMSMarker markerImageWithColor:restaurantMarkerColor];
            restaurantMarker.map = self.mapView;
            restaurantMarker.userData = restaurant;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - GMSMapViewDelegate

/**
 * 地図上の特定座標をタップした際に通知される。
 * マーカーをタップした際には通知されない。
 */
- (void)mapView:(GMSMapView *)mapVie didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    //NSLog(@"didTapAtCoordinate %f,%f", coordinate.latitude, coordinate.longitude);
}


/**
 * 地図の表示領域（カメラ）が変更された際に通知される。
 * アニメーション中は途中の表示領域が通知されたない場合があるが、最終的な位置で通知される。
 */
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    //NSLog(@"didChangeCameraPosition %f,%f", position.target.latitude, position.target.longitude);
}


/**
 * 地図上の特定の座標を長押しした際に通知される。
 */
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    //NSLog(@"didLongPressAtCoordinate %f,%f", coordinate.latitude, coordinate.longitude);
}

/**
 * マーカーがタップされた際に通知される。
 * NOを返すと通常の動作であるマーカーウィンドウを表示する。
 * YESを返すとマーカーウィンドウを表示しない。
 */
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    //NSLog(@"didTapMarker title:%@, snippet:%@", [marker title], [marker snippet]);
    return NO;
}

/**
 * マーカーのウィンドウをタップした際に通知される。
 */
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    //NSLog(@"didTapInfoWindowOfMarker title:%@, snippet:%@", [marker title], [marker snippet]);
    
    // markerのuserDataのクラスにより場合分け
    RestaurantItem *restaurant = [[RestaurantItem alloc] init];
    EventItem *event = [[EventItem alloc] init];
    
    if ([marker.userData class] == [event class]) {
        
        event = marker.userData;
        
        // EVENT詳細Viewを生成
        EventDetailViewController *eventDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
        eventDetailViewController.event = event;
        // EVENTタブを選択済にする
        UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
        self.tabBarController.selectedViewController = eventTabViewController;
        [eventTabViewController popToRootViewControllerAnimated:NO];
        // EVENT詳細へ遷移
        [eventTabViewController pushViewController:eventDetailViewController animated:YES];
        //[eventTabViewController.viewControllers[0] performSegueWithIdentifier:@"toEventDetailViewController" sender:self];

        
    } else if ([marker.userData class] == [restaurant class]) {
        
        restaurant = marker.userData;
        
        // RESTAURANT詳細Viewを生成
        RestaurantDetailViewController *restaurantDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetailViewController"];
        restaurantDetailViewController.restaurant = restaurant;
        // RESTAURANTタブを選択済にする
        UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
        self.tabBarController.selectedViewController = restaurantTabViewController;
        [restaurantTabViewController popToRootViewControllerAnimated:NO];
        // RESTAURANT詳細へ遷移
        [restaurantTabViewController pushViewController:restaurantDetailViewController animated:YES];
        
    }
}


/**
 * マーカーがタップされて、ウィンドウが表示されるタイミングで通知される。
 * 独自のウィンドウを返すことができる。
 */
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    
    MapCustumMarkerView *view = [[[NSBundle mainBundle] loadNibNamed:@"MapCustumMarkerView"
                                                               owner:self
                                                             options:nil] lastObject];
    
    RestaurantItem *restaurant = [[RestaurantItem alloc] init];
    EventItem *event = [[EventItem alloc] init];
    
    // タイトルは全部表示させる
    [view.text setNumberOfLines:0];
    CGFloat originalTextHeight = view.text.frame.size.height;
    if ([marker.userData class] == [event class]) {
        
        event = marker.userData;
        [view.image setImage:event.image];
        view.text.text = event.title;
        view.subText.text = event.information.sponsor;
        
    } else if ([marker.userData class] == [restaurant class]) {
        
        restaurant = marker.userData;
        [view.image setImage:restaurant.image];
        view.text.text = restaurant.name;
        view.subText.text = restaurant.type;
        
    }
    
    // 無理やりリサイズ
    [view.text sizeToFit];
    CGRect viewRect = view.frame;
    viewRect.size.height += view.text.frame.size.height - originalTextHeight;
    view.frame = viewRect;
    CGRect subTextRect = view.subText.frame;
    subTextRect.origin.y += view.text.frame.size.height - originalTextHeight;
    view.subText.frame = subTextRect;
    
    return view;
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


@end
