//
//  LocationPickerView.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerView.h"

@implementation LocationPickerView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 100)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [self setupTableView];

    }
    return self;
}


- (void)layoutSubviews
{
    self.textField.text = @"TEST";
    [self addSubview:self.textField];
}

- (void)setupTableView
{
    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(0, 30, 320, 120) style:UITableViewStylePlain];
    [self.autocompleteTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.autocompleteTableView setBackgroundColor:[UIColor whiteColor]];
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = NO;
    [self addSubview:self.autocompleteTableView];
}

#pragma mark TextField Delegate Methods
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
//    [autocompleteUrls removeAllObjects];
//    for(NSString *curString in pastUrls) {
//        NSRange substringRange = [curString rangeOfString:substring];
//        if (substringRange.location == 0) {
//            [autocompleteUrls addObject:curString];
//        }
//    }
    [self.autocompleteTableView reloadData];
}

#pragma mark TextField Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.textLabel.text = @"hi";
    return cell;
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
