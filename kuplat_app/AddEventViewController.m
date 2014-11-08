//
//  AddEventViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "AddEventViewController.h"

@implementation AddEventViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self displayMap];
    
    self.dateSelectionY.dropList = @[@"2014年", @"2015年"];
    self.dateSelectionM.dropList = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
    self.dateSelectionD.dropList = @[@"1日", @"2日", @"3日", @"4日", @"5日", @"6日", @"7日", @"8日", @"9日", @"10日", @"11日", @"12日", @"13日", @"14日", @"15日", @"16日", @"17日", @"18日", @"19日", @"20日", @"21日", @"22日", @"23日", @"24日", @"25日", @"26日", @"27日", @"28日", @"29日", @"30日", @"31日"];
    self.dateSelectionH.dropList = @[@"1時", @"2時", @"3時", @"4時", @"5時", @"6時", @"7時", @"8時", @"9時", @"10時", @"11時", @"12時", @"13時", @"14時", @"15時", @"16時", @"17時", @"18時", @"19時", @"20時", @"21時", @"22時", @"23時"];
    self.dateSelectionMi.dropList = @[@"00分", @"15分", @"30分", @"45分"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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



- (IBAction)pushAddEventImageBotton:(id)sender {
    
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

- (IBAction)pushAddEventBotton:(id)sender {
}
@end
