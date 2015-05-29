//
//  ViewController.m
//  PlacePicker
//
//  Created by Vivian Wehner on 5/20/15.
//  Copyright (c) 2015 Vivian Wehner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationPickerController = [[LocationPickerViewController alloc] init];
}

- (void)viewWillLayoutSubviews
{
    [self presentViewController:self.locationPickerController animated:NO completion:^{
        NSLog(@"View did appear");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
