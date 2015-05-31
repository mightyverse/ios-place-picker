//
//  LocationPickerView.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerView.h"
#import "LocationPickerMapViewController.h"

@implementation LocationPickerView

static int textFieldHeight = 30;
static int textLabelHeight = 40;
static int maxHeight = 80;
static int textFieldWidth = 240;

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:25/256.0 green:66/256.0 blue:86/256.0 alpha:0.90];
        self.labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, maxHeight)];
        [self addSubview:self.labelView];
        self.labelView.backgroundColor = [UIColor colorWithRed:28/256.0 green:36/256.0 blue:40/256.0 alpha:0.90];
    }
    return self;
    
}

- (void)layoutSubviews
{
    self.textField.text = @"TEST";
    [self setupTextField];
    [self addSubview:self.textField];
}

- (void)setupTextField
{
    int leftOffset = 8;
    
    self.textInstructions = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, textLabelHeight)];
    [self.textInstructions setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.textInstructions setTextColor:[UIColor whiteColor]];
    [self.textInstructions setText:@"Enter city, zip code, or airport location"];
    [self.textInstructions setTextAlignment:NSTextAlignmentCenter];
    [self.labelView addSubview:self.textInstructions];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(leftOffset, textLabelHeight, textFieldWidth, textFieldHeight)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.textColor = [UIColor blackColor];
    self.textField.delegate = self;
    // If we want a custom button, this is how to access
//    UIButton *clearButton = [self.textField valueForKey:@"_clearButton"];
//    [clearButton setImage:[UIImage new] forState:UIControlStateNormal];
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(textFieldWidth + leftOffset + 5, textLabelHeight, textLabelHeight, 60)];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton sizeToFit];
    [self.cancelButton addTarget:self.delegate action:@selector(didSelectCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.labelView addSubview:self.cancelButton];

    // Setup search icon
    UILabel *magnifyingGlass = [[UILabel alloc] init];
    [magnifyingGlass setText:[[NSString alloc] initWithUTF8String:"\xF0\x9F\x94\x8D"]];
    [magnifyingGlass sizeToFit];
    
    [self.textField setLeftView:magnifyingGlass];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];
}

#pragma mark TextField Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //self.autocompleteTableView.hidden = NO;
    
    [self.delegate shouldHideTableview:NO];
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self.delegate showPossibleMatchesForSubstring:substring];
    return YES;
}


// It is important for you to hide the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
