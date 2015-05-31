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
- (id)initWithLocation:(CLLocation*)location description:(NSString*)description;

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, strong) UILabel *bottomLabel;

@end
