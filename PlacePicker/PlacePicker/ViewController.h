//
//  ViewController.h
//  PlacePicker
//
//  Created by Vivian Wehner on 5/20/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPickerViewController.h"
@class LocationPickerViewController;

@interface ViewController : UIViewController

@property (strong, readwrite) LocationPickerViewController *locationPickerController;

@end
