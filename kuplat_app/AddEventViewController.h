//
//  AddEventViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DropdownMenuView.h"
#import <UIScrollView+EKKeyboardAvoiding.h>
#import <ActionSheetPicker-3.0/ActionSheetDatePicker.h>
#import <ActionSheetPicker-3.0/ActionSheetStringPicker.h>

@interface AddEventViewController : UIViewController<GMSMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, DropdownMenuViewDelegate, UITextFieldDelegate>

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *eventTitleField;

@property (nonatomic, strong) NSArray *eventType;
@property (nonatomic, assign) NSInteger selectedEventTypeIndex;
@property (weak, nonatomic) IBOutlet UITextField *eventTypeField;
- (IBAction)pushEventTypeField:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *eventSponsorField;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDate *selectedStartTime;
@property (nonatomic, strong) NSDate *selectedEndTime;
@property (weak, nonatomic) IBOutlet UITextField *dateSelection;
@property (weak, nonatomic) IBOutlet UITextField *startTimeSelection;
@property (weak, nonatomic) IBOutlet UITextField *endTimeSelection;
- (IBAction)pushDateSelection:(id)sender;
- (IBAction)pushStartTimeSelection:(id)sender;
- (IBAction)pushEndTimeSelection:(id)sender;

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


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)tappedMenuButton:(id)sender;



@end
