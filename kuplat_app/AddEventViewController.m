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
    
    // メニューを設置
    [self setDropdownMenu];
    
    
    // 背景をキリックしたら、キーボードを隠す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //[self.scrollView setKeyboardAvoidingEnabled:YES];
    
    self.eventType = @[@"部活・サークル", @"就活", @"セミナー・他"];
    self.selectedDate = [NSDate date];
    self.selectedStartTime = [NSDate date];
    self.selectedEndTime = [NSDate date];
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


// イベント系統の選択
- (IBAction)pushEventTypeField:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"イベント系統の選択"
                                            rows:self.eventType
                                initialSelection:self.selectedEventTypeIndex
                                          target:self successAction:@selector(eventTypeWasSelected:element:)
                                    cancelAction:@selector(actionPickerCancelled:) origin:sender];
}
- (void)eventTypeWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedEventTypeIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.eventTypeField.text = (self.eventType)[(NSUInteger) self.selectedEventTypeIndex];
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}

// 日付選択
- (IBAction)pushDateSelection:(id)sender {
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"開催日の選択"
                                                       datePickerMode:UIDatePickerModeDate
                                                         selectedDate:self.selectedDate
                                                               target:self
                                                               action:@selector(dateWasSelected:element:)
                                                               origin:sender];
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    // カレンダーは西暦(iOSの設定のカレンダーに該当)
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [NSLocale currentLocale];
    [datePicker setCalendar:gregorian];
    [datePicker addCustomButtonWithTitle:@"今日" value:[NSDate date]];
    [datePicker setHideCancel:YES];
    [datePicker showActionSheetPicker];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd (E)"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [self.dateSelection setText:[dateFormatter stringFromDate:selectedDate]];
}

// 開始時刻選択
- (IBAction)pushStartTimeSelection:(id)sender {
    
    NSInteger minuteInterval = 10;
    //clamp date
    NSInteger referenceTimeInterval = (NSInteger)[self.selectedStartTime timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceTimeInterval % (minuteInterval *60);
    NSInteger timeRoundedTo10Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>((minuteInterval*60)/2)) {/// round up
        timeRoundedTo10Minutes = referenceTimeInterval +((minuteInterval*60)-remainingSeconds);
    }
    
    self.selectedStartTime = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo10Minutes];
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"開始時刻の選択"
                                                                      datePickerMode:UIDatePickerModeTime
                                                                        selectedDate:self.selectedStartTime
                                                                              target:self
                                                                              action:@selector(startTimeWasSelected:element:)
                                                                              origin:sender];
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [datePicker setMinuteInterval:minuteInterval];
    [datePicker showActionSheetPicker];
}
-(void)startTimeWasSelected:(NSDate *)selectedTime element:(id)element {
    self.selectedStartTime = selectedTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm"];
    [self.startTimeSelection setText:[dateFormatter stringFromDate:selectedTime]];
}


// 終了時刻選択
- (IBAction)pushEndTimeSelection:(id)sender {
    
    NSInteger minuteInterval = 10;
    //clamp date
    NSInteger referenceTimeInterval = (NSInteger)[self.selectedEndTime timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceTimeInterval % (minuteInterval *60);
    NSInteger timeRoundedTo10Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>((minuteInterval*60)/2)) {/// round up
        timeRoundedTo10Minutes = referenceTimeInterval +((minuteInterval*60)-remainingSeconds);
    }
    
    self.selectedEndTime = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo10Minutes];
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"終了時刻の選択"
                                                                      datePickerMode:UIDatePickerModeTime
                                                                        selectedDate:self.selectedEndTime
                                                                              target:self
                                                                              action:@selector(endTimeWasSelected:element:)
                                                                              origin:sender];
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [datePicker setMinuteInterval:minuteInterval];
    [datePicker showActionSheetPicker];
}

-(void)endTimeWasSelected:(NSDate *)selectedTime element:(id)element {
    self.selectedEndTime = selectedTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm"];
    [self.endTimeSelection setText:[dateFormatter stringFromDate:selectedTime]];
}

- (IBAction)pushAddEventBotton:(id)sender {
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

// キーボードを隠す処理
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}


@end
