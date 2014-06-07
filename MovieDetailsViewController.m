//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

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
    NSArray *image = [[NSArray alloc]init];
    image = self.movieData[@"posters"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image valueForKey:@"detailed"]]];
    
#pragma -
#pragma Poster Image loading
    
    //load images asyc using the AFNetworking pod
    NSURL *url = [NSURL URLWithString:[image valueForKey:@"original"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    //TODO: add a place holder image later
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    
    NSLog(@"logo url is %@", url);
    
    __weak UIImageView *weakImage = self.posterImageView;

[weakImage setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    weakImage.image = image;
} failure:nil];

#pragma end
    
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
