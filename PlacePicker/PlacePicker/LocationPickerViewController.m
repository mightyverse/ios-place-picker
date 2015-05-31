//
//  LocationPickerViewController.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerViewController.h"
#import "LocationPickerMapViewController.h"

@interface LocationPickerViewController ()

@end

@implementation LocationPickerViewController

static int barOffset = 18;
static int textFieldHeight = 80;

- (id)init
{
    self = [super init];
    
    
    if (self != nil){
        self.view.backgroundColor = [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1.0];
        [self setupLocationPickerView];
        [self setupCountryData];
        [self setupTableView];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [self.view addSubview:self.locationPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setup methods

- (void)setupLocationPickerView
{
    self.locationPickerView = [[LocationPickerView alloc] initWithFrame:CGRectMake(0, barOffset, self.view.frame.size.width, textFieldHeight)];
    self.locationPickerView.delegate = self;
}

// Do all the parsing and populate a dictionary where keys are the description, and value is the lat long
// in a CLLocation Object.
- (void)setupCountryData
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"csv"];
    NSString *strFile = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!strFile) {
        NSLog(@"Error reading file.");
    }
    NSArray *arrayCountry = [[NSArray alloc] init];
    arrayCountry = [strFile componentsSeparatedByString:@"\n"];
    
    self.foundMatches = [[NSMutableArray alloc]init];
    self.dictionaryOfPlaces = [[NSMutableDictionary alloc]init];
    
    NSArray *dataComponents = [[NSArray alloc] init];
    for(NSString *countryname in arrayCountry) {
        if (countryname.length > 0) {
            dataComponents = [countryname componentsSeparatedByString:@","];
            
            double latitude = [(NSString*)[dataComponents objectAtIndex:3] doubleValue];
            double longitude = [(NSString*)[dataComponents objectAtIndex:4] doubleValue];
            NSString *description = [NSString stringWithFormat:@"%@,%@",[dataComponents objectAtIndex:0], [dataComponents objectAtIndex:1]];
            CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
            if (self.dictionaryOfPlaces[description]) {
                [self.dictionaryOfPlaces[description] addObject:newLocation];
            }
            else{
                NSMutableArray * locations = [[NSMutableArray alloc]initWithObjects:newLocation, nil];
                [self.dictionaryOfPlaces setValue:locations forKey:description];
            }
        }
    }
}

// The tableview of possible values
-(void)setupTableView
{
    int locationHeight = self.locationPickerView.frame.size.height;
    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
                                  CGRectMake(0, textFieldHeight + barOffset, self.view.frame.size.width, self.view.frame.size.height - locationHeight) style:UITableViewStylePlain];
    [self.autocompleteTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = YES;
    self.autocompleteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.autocompleteTableView setBackgroundColor:[UIColor colorWithRed:25/256.0 green:66/256.0 blue:86/256.0 alpha:0.90]];
    [self.view addSubview:self.autocompleteTableView];
}

#pragma mark LocationPickerViewDelegate Methods
- (void)showPossibleMatchesForSubstring:(NSString*)substring
{
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.foundMatches removeAllObjects];
    NSArray *allKeys = self.dictionaryOfPlaces.allKeys;
    for(NSString *curString in allKeys) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.foundMatches addObject:curString];
        }
    }
    self.currentSubstring = substring;
    [self.autocompleteTableView reloadData];
}

- (void)shouldHideTableview:(BOOL)shouldHideTableview
{
    self.autocompleteTableView.hidden = shouldHideTableview;
}

- (void)didSelectCancel
{
    NSLog(@"Cancel");
}

#pragma mark Tableview Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.foundMatches count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    NSString *description = [self.foundMatches objectAtIndex:indexPath.row];
    CLLocation *location = [[self.dictionaryOfPlaces objectForKey:description]objectAtIndex:0];
    [self didSelectLocation:location withDescription:description];
}

#pragma mark MapView related methods
- (void)didSelectLocation:(CLLocation*)location withDescription:(NSString*)description
{
    LocationPickerMapViewController *mapViewController = [[LocationPickerMapViewController alloc]initWithLocation:location description:description];
    [self presentViewController:mapViewController animated:NO completion:^{
        NSLog(@"Presented Map View controller");
    }];
}

@end
