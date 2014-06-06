//
//  TopDvdsViewController.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TopDvdsViewController.h"

@interface TopDvdsViewController ()

@end

@implementation TopDvdsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDefaults];
    // Do any additional setup after loading the view from its nib.
}

- (void) loadDefaults {
    self.title = @"Top DVDs";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
