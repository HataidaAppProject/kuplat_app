//
//  AddEventViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ANZDropDownField.h"
#import "DropdownMenuView.h"

@interface AddEventViewController : UIViewController<GMSMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *eventTitleField;

@property (weak, nonatomic) IBOutlet UITextField *eventSponsorField;

@property (weak, nonatomic) IBOutlet ANZDropDownField *dateSelectionY;
@property (weak, nonatomic) IBOutlet ANZDropDownField *dateSelectionM;
@property (weak, nonatomic) IBOutlet ANZDropDownField *dateSelectionD;
@property (weak, nonatomic) IBOutlet ANZDropDownField *dateSelectionH;
@property (weak, nonatomic) IBOutlet ANZDropDownField *dateSelectionMi;

@property (weak, nonatomic) IBOutlet UITextField *eventCostField;

@property (weak, nonatomic) IBOutlet UIView *mapSuperView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *marker;

@property (weak, nonatomic) IBOutlet UITextView *eventOverviewField;

@property (weak, nonatomic) IBOutlet UITextField *eventSponsorPhoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *eventURL;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;


- (IBAction)pushAddEventImageBotton:(id)sender;

- (IBAction)pushAddEventBotton:(id)sender;

@end
