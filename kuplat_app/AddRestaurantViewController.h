//
//  AddRestaurantViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ANZDropDownField.h"
#import "RestaurantMenuPriceTextFieldView.h"
#import "DropdownMenuView.h"

@interface AddRestaurantViewController : UIViewController<GMSMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *restaurantNameField;

@property (weak, nonatomic) IBOutlet ANZDropDownField *typeSelectionField;

@property (weak, nonatomic) IBOutlet UIView *mapSuperView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *marker;

@property (weak, nonatomic) IBOutlet ANZDropDownField *photoTypeSelectionField;
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

@end
