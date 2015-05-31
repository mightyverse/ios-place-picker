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

- (void)shouldHideTableview:(BOOL)shouldHideTableview;

- (void)showPossibleMatchesForSubstring:(NSString*)substring;

- (void)didSelectCancel;

@end

@interface LocationPickerView : UIView <UITextFieldDelegate>

@property (strong, nonatomic) id <LocationPickerDelegate> delegate;

@property (strong, nonatomic) UIView *labelView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *textInstructions;
@property (strong, nonatomic) UIButton *cancelButton;
@end
