//
//  LocationPickerViewController.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/26/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "LocationPickerViewController.h"

@interface LocationPickerViewController ()

@end

@implementation LocationPickerViewController


- (id)init
{
    self = [super init];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    NSLog(@"HI");
    if (self != nil)
    {
        self.locationPickerView = [[LocationPickerView alloc]init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    //[self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.locationPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
