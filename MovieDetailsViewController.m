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
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;


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
    self.movieTitleLabel.text = self.movieData[@"title"];
    self.synopsisLabel.text = self.movieData[@"synopsis"];
    [self.synopsisLabel sizeToFit];
    
    //load the low res image first
    [self loadImageFromUrl:[self.movieData valueForKeyPath:@"posters.detailed"] into:self.posterImageView];

}


- (void)loadImageFromUrl: (NSString *) imageURL into: (UIImageView *) imageView{
    // uses AFnetworking async to load images
    NSURL *url = [NSURL URLWithString:imageURL];
    
    //TODO: add a place holder image later
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    
    [imageView setImageWithURL:url placeholderImage:placeholderImage];
    
}

-(void)viewDidAppear:(BOOL)animated {
    //load the high res poster image after teh view loads
    [self loadImageFromUrl:[self.movieData valueForKeyPath:@"posters.original"] into:self.posterImageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.movieScrollView.autoresizesSubviews = YES;
    self.movieScrollView.contentMode = UIViewContentModeScaleToFill;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
