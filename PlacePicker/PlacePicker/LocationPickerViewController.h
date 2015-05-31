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

@interface LocationPickerViewController : UIViewController <LocationPickerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) LocationPickerView *locationPickerView;
@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *foundMatches;
@property (strong, nonatomic) NSArray *possiblePlaces;
@property (strong, nonatomic) NSMutableDictionary *dictionaryOfPlaces;
@property (strong, nonatomic) NSString *currentSubstring;

@end