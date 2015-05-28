//
//  LocationPickerView.h
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationPickerView : UIView <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITextField* textField;
@property (strong, nonatomic) UITableView* autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *foundMatches;
@property (strong, nonatomic) NSArray *possiblePlaces;
@end
