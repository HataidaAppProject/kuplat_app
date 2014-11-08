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
#import "DropdownMenuView.h"

@interface AddRestaurantViewController : UIViewController<GMSMapViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *restaurantNameField;

@property (weak, nonatomic) IBOutlet ANZDropDownField *typeSelectionField;

@property (weak, nonatomic) IBOutlet UIView *mapSuperView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *marker;

@property (weak, nonatomic) IBOutlet ANZDropDownField *photoTypeSelectionField;

@property (weak, nonatomic) IBOutlet UIView *restaurantMenuField;

@property (weak, nonatomic) IBOutlet UITextView *restaurantBusinessHours;

@property (weak, nonatomic) IBOutlet UITextField *restaurantClosedDays;

@property (weak, nonatomic) IBOutlet UITextField *restaurantPhoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *restaurantURL;



@property (weak, nonatomic) IBOutlet UIView *contentView;



- (IBAction)pusuAddRestaurantBotton:(id)sender;

@end
