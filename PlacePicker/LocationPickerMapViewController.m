//
//  LocationPickerMapView.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/27/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerMapViewController.h"

@implementation LocationPickerMapViewController

static int labelHeight = 40;

- (id)initWithLocation:(CLLocation*)location description:(NSString*)description
{
    self = [super init];
    if (self) {
        self.description = description;
        self.location = location;
    }
    return self;
}

- (void)setupMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - labelHeight)];
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.delegate = self;
    
    // Create annotation showing location of city
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.location.coordinate];
    [annotation setTitle:self.description];
    [self.mapView addAnnotation:annotation];
    
    // Zoom into where annotation is
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.location.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.2, 0.2);
    [self.mapView setRegion:mapRegion animated: YES];
}

// Hide status bar for this view
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)setupBottomLabelView
{
    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - labelHeight, self.view.frame.size.width, labelHeight)];
    [self.bottomLabel setBackgroundColor:[UIColor whiteColor]];
    [self.bottomLabel setTextAlignment:NSTextAlignmentCenter];
    [self.bottomLabel setText:self.description];
}

- (void)setupPopupView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.description
                                                    message:@"Accent location saved."
                                                   delegate:nil
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMapView];
    [self setupBottomLabelView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.bottomLabel];
    [self setupPopupView];
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
