//
//  AddRestaurantViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "RestaurantMenuPriceTextFieldView.h"
#import "DropdownMenuView.h"
#import "UIScrollView+EKKeyboardAvoiding.h"
#import <ActionSheetPicker-3.0/ActionSheetStringPicker.h>

@interface AddRestaurantViewController : UIViewController <GMSMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, DropdownMenuViewDelegate>

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *restaurantNameField;

@property (nonatomic, strong) NSArray *restaurantType;
@property (nonatomic, assign) NSInteger selectedRestaurantTypeIndex;
@property (weak, nonatomic) IBOutlet UITextField *restaurantTypeField;
- (IBAction)pushRestaurantTypeField:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mapSuperView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *marker;

@property (nonatomic, strong) NSArray *photoType;
@property (nonatomic, assign) NSInteger selectedPhotoTypeIndex;
@property (weak, nonatomic) IBOutlet UITextField *photoTypeField;
- (IBAction)pushPhotoTypeField:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@property (weak, nonatomic) IBOutlet UIView *restaurantMenuField;
@property (strong, nonatomic) NSMutableArray *restaurantMenuItems;
@property (weak, nonatomic) IBOutlet UIButton *addRestaurantMenuBotton;

@property (weak, nonatomic) IBOutlet UITextView *restaurantBusinessHours;

@property (weak, nonatomic) IBOutlet UITextField *restaurantClosedDays;

@property (weak, nonatomic) IBOutlet UITextField *restaurantPhoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *restaurantURL;



@property (weak, nonatomic) IBOutlet UIView *contentView;


- (IBAction)pushAddRestaurantImageBotton:(id)sender;
- (IBAction)pushAddRestaurantMenuBotton:(id)sender;
- (IBAction)pusuAddRestaurantBotton:(id)sender;


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)tappedMenuButton:(id)sender;

@end
