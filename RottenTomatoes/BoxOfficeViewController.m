//
//  BoxOfficeViewController.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "BoxOfficeViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "CWStatusBarNotification.h"

@interface BoxOfficeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property NSArray *moviesData;

//notification bar
@property CWStatusBarNotification *notification;

//loading HUD
@property MBProgressHUD *hud;

@end

@implementation BoxOfficeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self checkNetwork];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.hud hide:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pullToRefresh];
    [self loadDefaults];
    [self getDataFromApi];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Reachability

- (void) checkNetwork {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];

    reach.reachableBlock = ^(Reachability *reach) {
        NSLog(@"Internet reachable");
        [self hideNetworkErrorNotification];
    };
    
    reach.unreachableBlock = ^(Reachability*reach) {
        NSLog(@"UNREACHABLE!");
        [self showNetworkErrorNotification:@"Internet not found"];
    };
    
    [reach startNotifier];
    
}

-(void)reachabilityChanged:(NSNotification*)note{
    
    Reachability * reach = [note object];
    
    if([reach isReachable]) {
        [self hideNetworkErrorNotification ];
    } else {
        [self showNetworkErrorNotification:@"Internet not found"];
    }
}

- (void) showNetworkErrorNotification: (NSString *) withMessage {
    //change label and background colour of notification
    self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.91 green:0.25 blue:0.11 alpha:1];
    self.notification.notificationLabelTextColor = [UIColor colorWithRed:0.95 green:0.95 blue:1 alpha:1];
    
    [self.notification displayNotificationWithMessage:withMessage completion:nil];

}

- (void) hideNetworkErrorNotification {
    [self.notification dismissNotification];
}


#pragma mark - Pull to Refresh

- (void) pullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(getDataFromApi) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

#pragma mark - Call API to get data

- (void) getDataFromApi {
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6h3yq9mnqksypq27xzkwz9ww";
//    NSString *url = @"http://127.0.0.1:8080/rotten.json";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.moviesData = [object objectForKey:@"movies"];
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    }];
    
}

#pragma mark - Load defaults
- (void) loadDefaults {
    self.title = @"Box Office";
    
    self.tableView.rowHeight = 92;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    //set notification bar defaults
    self.notification = [CWStatusBarNotification new];
    
}

#pragma mark - Table methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.moviesData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    
    NSDictionary *movie = self.moviesData[indexPath.row];
    
    cell.movieTitleLabel.text = movie[@"title"];
    cell.movieSynopsisLabel.text = movie[@"synopsis"];
    
    //load images asyc using the AFNetworking pod
    NSURL *url = [NSURL URLWithString:[movie valueForKeyPath:@"posters.profile"]];
    //TODO: add a place holder image later
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    [cell.movieImageView setImageWithURL:url placeholderImage:placeholderImage];
    
    // Tomatometer (critics) rating section
    NSString *tomatoRating = [movie valueForKeyPath:@"ratings.critics_rating"];
    cell.tomatometerLabel.text = [NSString stringWithFormat:@"%@%%",[movie valueForKeyPath:@"ratings.critics_score"]];
    
    if ([tomatoRating isEqualToString:@"Rotten"]) {
        cell.tomatometerImage.image = [UIImage imageNamed:@"green_tomato"];
    } else {
        cell.tomatometerImage.image = [UIImage imageNamed:@"red_tomato"];
    }
    
    // Audience rating section
    NSString *audienceRating = [movie valueForKeyPath:@"ratings.audience_rating"];
    cell.audienceLabel.text = [NSString stringWithFormat:@"%@%%",[movie valueForKeyPath:@"ratings.audience_score"]];
    
    if ([audienceRating isEqualToString:@"Spilled"]) {
        cell.audienceImage.image = [UIImage imageNamed:@"popcorn_down"];
    } else {
        cell.audienceImage.image = [UIImage imageNamed:@"popcorn_up"];
    }

    // MPAA rating
    cell.mpaaRatingLabel.text = [movie valueForKeyPath:@"mpaa_rating"];
    
    UIView *cellBackgroundView = [[UIView alloc]init];
    [cellBackgroundView setBackgroundColor:[UIColor colorWithRed:0.61 green:0.62 blue:0.65 alpha:1]];
    [cell setSelectedBackgroundView:cellBackgroundView];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *moviedetailsViewController = [[MovieDetailsViewController alloc]init];
    NSDictionary *movies = self.moviesData[indexPath.row];
    moviedetailsViewController.movieData = movies;
    
    [self.navigationController pushViewController:moviedetailsViewController animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
