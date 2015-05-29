//
//  LocationPickerMapView.h
//  PlacePicker
//
//  Created by Vivian Wehner on 5/27/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationPickerMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, retain) MKMapView *mapView;

@end
