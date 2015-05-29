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
static int statusBarPadding = 20;
static int textLabelHeight = 40;
static int maxHeight = 80;
static int textFieldWidth = 240;

@synthesize delegate;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, statusBarPadding, 320, [[UIScreen mainScreen] bounds].size.height)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:25/256.0 green:66/256.0 blue:86/256.0 alpha:0.90];
        self.labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, maxHeight)];
        [self addSubview:self.labelView];
        self.labelView.backgroundColor = [UIColor colorWithRed:28/256.0 green:36/256.0 blue:40/256.0 alpha:0.90];
        [self setupTextField];
        [self setupTableView];

    }
    return self;
}


- (void)layoutSubviews
{
    self.textField.text = @"TEST";
    [self addSubview:self.textField];
}

- (void)setupTextField
{
    int leftOffset = 5;
    
    self.textInstructions = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, textLabelHeight)];
    [self.textInstructions setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.textInstructions setTextColor:[UIColor whiteColor]];
    [self.textInstructions setText:@"Enter city, zip code, or airport location"];
    [self.textInstructions setTextAlignment:NSTextAlignmentCenter];
    [self.labelView addSubview:self.textInstructions];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(leftOffset, textLabelHeight, textFieldWidth, textFieldHeight)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor blackColor];
    self.textField.textColor = [UIColor whiteColor];
    self.textField.delegate = self;
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(textFieldWidth + leftOffset + 5, textLabelHeight, textLabelHeight, 60)];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton sizeToFit];
    [self.labelView addSubview:self.cancelButton];

    // Setup search icon
    UILabel *magnifyingGlass = [[UILabel alloc] init];
    [magnifyingGlass setText:[[NSString alloc] initWithUTF8String:"\xF0\x9F\x94\x8D"]];
    [magnifyingGlass sizeToFit];
    
    [self.textField setLeftView:magnifyingGlass];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];
    
    // Setup data arrays
    self.possiblePlaces = @[@"hi", @"hello", @"howdy", @"help", @"hit"];
    self.foundMatches = [[NSMutableArray alloc]init];
}


- (void)setupTableView
{
    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(0, (2 * textFieldHeight) + 20, self.frame.size.width, self.frame.size.height - maxHeight) style:UITableViewStylePlain];
    [self.autocompleteTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = YES;
    [self.autocompleteTableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.autocompleteTableView];
}

#pragma mark TextField Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Done editing");

    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.foundMatches removeAllObjects];
    for(NSString *curString in self.possiblePlaces) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.foundMatches addObject:curString];
        }
    }
    [self.autocompleteTableView reloadData];
}

#pragma mark TextField Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.foundMatches count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.textLabel.text = [self.foundMatches objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected row");
    [self.delegate didSelectLocation:[[CLLocation alloc] initWithLatitude:117.0 longitude:38.0]];
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
