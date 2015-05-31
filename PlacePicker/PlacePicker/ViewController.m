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
    self.locationPickerController.delegate = self;
//    [self presentViewController:self.locationPickerController animated:NO completion:^{
//        NSLog(@"Picker View was presented");
//    }];
    [self.view addSubview:self.locationPickerController.view];

}

- (void)viewWillLayoutSubviews
{
}

- (void)didPickLocation:(CLLocation*)location withDescription:(NSString*)description
{
    //[self dismissViewControllerAnimated:NO completion:nil];
    [self.locationPickerController.view removeFromSuperview];
    [self.view addSubview:self.locationPickerController.locationPickerMapController.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
