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

@interface AddRestaurantViewController : UIViewController<GMSMapViewDelegate, DropdownMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet ANZDropDownField *typeSelectionField;
@property (weak, nonatomic) IBOutlet ANZDropDownField *photoTypeSelectionField;



// Map
@property(strong,nonatomic) GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *mapSuperView;

@end
