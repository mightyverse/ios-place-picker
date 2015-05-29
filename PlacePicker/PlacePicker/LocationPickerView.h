//
//  LocationPickerView.h
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol LocationPickerDelegate <NSObject>

- (void)didSelectLocation:(CLLocation*)location;

@end

@interface LocationPickerView : UIView <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id <LocationPickerDelegate> delegate;

@property (strong, nonatomic) UIView *labelView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *textInstructions;
@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *foundMatches;
@property (strong, nonatomic) NSArray *possiblePlaces;
@property (strong, nonatomic) UIButton *cancelButton;
@end
