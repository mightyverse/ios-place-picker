//
//  LocationPickerMapView.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/27/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerMapViewController.h"

@implementation LocationPickerMapViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc]
               initWithFrame:self.view.bounds
               ];
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeHybrid;
    mapView.delegate = self;
    [self.view addSubview:mapView];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
