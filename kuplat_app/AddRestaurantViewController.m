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
    
    self.restaurantMenuItems = [[NSMutableArray alloc] init];
    [self.restaurantMenuField setBackgroundColor:[UIColor clearColor]];
    
    [self addMenuField];
    
    self.typeSelectionField.dropList = @[@"カフェ", @"ラーメン", @"レストラン", @"パン・スイーツ", @"居酒屋・バー" ];
    self.photoTypeSelectionField.dropList = @[@"店舗", @"フード", @"メニュー", @"その他"];
    
    // メニューを設置
    [self setDropdownMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


////
//   マップ
////
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
    
    // 方位固定
    [self.mapView.settings setRotateGestures:NO];
    // ユーザの現在地の表示オプション
    self.mapView.myLocationEnabled = YES;
    
    
    [self.mapSuperView addSubview:self.mapView];
    
    // 中心にマーカ
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

- (void)addMenuPriceTextField
{
    
}


////
//  メニューFieldを増やす
////
-(void)addMenuField
{
    
    RestaurantMenuPriceTextFieldView *newMenuFieldView = [[RestaurantMenuPriceTextFieldView alloc] initWithFrame:CGRectZero];
    
    [self.restaurantMenuField addSubview:newMenuFieldView];
    [newMenuFieldView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *layoutConstraints = [[NSMutableArray alloc] init];
    
    // 最下部のメニューの底面にTopを合わせる
    // 最初はViewのトップに合わせる
    if (self.restaurantMenuItems.count != 0) {
        [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.restaurantMenuItems.lastObject
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:newMenuFieldView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    } else {
        [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.restaurantMenuField
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:newMenuFieldView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    }
    // 左右
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.restaurantMenuField
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:newMenuFieldView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.restaurantMenuField
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:newMenuFieldView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
    // メニュー情報のリストの高さを伸ばす -制約の取消方法が分からなかったため >= で対処-
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.restaurantMenuField
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:newMenuFieldView.frame.size.height * (self.restaurantMenuItems.count + 1)]];
    
    [self.restaurantMenuField addConstraints:layoutConstraints];
    
    [self.restaurantMenuItems addObject:newMenuFieldView];
}

- (IBAction)pushAddRestaurantMenuBotton:(id)sender {
    
    // メニューと価格が書かれている時のみ増やす
    RestaurantMenuPriceTextFieldView *lastMenuFieldView = self.restaurantMenuItems.lastObject;
    if (lastMenuFieldView.menu.hasText && lastMenuFieldView.price.hasText) {
        [self addMenuField];
    }
    [self.addRestaurantMenuBotton setTitle:@"メニュー記入してください" forState:self.addRestaurantMenuBotton.state];
}

////
//   画像選択
////
- (IBAction)pushAddRestaurantImageBotton:(id)sender {
    
    // PhotoLibraryから写真を選択するためのUIImagePickerControllerを作成し、表示する
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // UIImagePickerControllerで選択された写真を取得する
    self.selectedImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Assets Library frameworkによって提供されるURLを取得する
    //NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    // 取得したURLを使用して、PHAssetを取得する
    //PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url,] options:nil];
    //PHAsset *asset = fetchResult.firstObject;
    
    // ラベルのテキストを更新する
    //self.dateLabel.text = asset.creationDate.description;
    //self.favoritelabel.text = (asset.favorite ? @"registered Favorites" : @"not registered Favorites");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)pusuAddRestaurantBotton:(id)sender {
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
