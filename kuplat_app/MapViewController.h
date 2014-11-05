//
//  MapViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MapCustumMarkerView.h"
#import "EventItem.h"
#import "RestaurantItem.h"
#import "EventDetailViewController.h"
#import "RestaurantDetailViewController.h"

@interface MapViewController : UIViewController<GMSMapViewDelegate>{
}

@property(strong,nonatomic) GMSMapView *mapView;

- (void)addMarkers;

@end

