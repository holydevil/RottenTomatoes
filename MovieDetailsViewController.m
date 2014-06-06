//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    self.title = self.movieData[@"title"];
    self.synopsisTextView.text = self.movieData[@"synopsis"];
    NSArray *images = [[NSArray alloc]init];
    images = self.movieData[@"posters"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[images valueForKey:@"detailed"]]];
    self.posterImageView.image = [UIImage imageWithData:imageData];
//    self.posterImageView.image = [UIImage ]
    
//    NSLog(@"%@ synopsis = ", self.movieData[@"synopsis"]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
