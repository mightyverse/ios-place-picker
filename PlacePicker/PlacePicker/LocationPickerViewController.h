//
//  LocationPickerViewController.h
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "ViewController.h"
#import "LocationPickerView.h"
#import "LocationPickerMapViewController.h"

@interface LocationPickerViewController : UIViewController <LocationPickerDelegate>
@property (strong, nonatomic) LocationPickerView *locationPickerView;

@end
