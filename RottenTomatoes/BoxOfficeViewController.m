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

@interface BoxOfficeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *tableData;
@property NSArray *moviesData;

@end

@implementation BoxOfficeViewController

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
    [self checkNetwork];
    [self loadDefaults];
    [self getDataFromApi];
    [self pullToRefresh];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) getDataFromApi {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6h3yq9mnqksypq27xzkwz9ww";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.moviesData = [object objectForKey:@"movies"];
        
//        NSLog(@"total enties are %d", self.moviesData.count);
        [self.tableView reloadData];
        
    }];
    
}

- (void) loadDefaults {
    self.title = @"Box Office";
    
    self.tableView.rowHeight = 97;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.moviesData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    
    NSDictionary *movies = self.moviesData[indexPath.row];
//    NSLog(@"title = %@ and synopsis = %@", movies[@"title"],movies[@"synopsis"]);
    
    cell.movieTitleLabel.text = movies[@"title"];
    cell.movieSynopsisLabel.text = movies[@"synopsis"];
    
    //load images asyc using the AFNetworking pod
    NSURL *url = [NSURL URLWithString:[movies valueForKeyPath:@"posters.thumbnail"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    //TODO: add a place holder image later
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    
    NSLog(@"logo url is %@", url);
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                   } failure:nil];
//    cell.movieImageView.image = weakCell.imageView.image;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *moviedetailsViewController = [[MovieDetailsViewController alloc]init];
    NSDictionary *movies = self.moviesData[indexPath.row];
    moviedetailsViewController.movieData = movies;
    
    [self.navigationController pushViewController:moviedetailsViewController animated:YES];
    
    
}

- (void) pullToRefresh {
    
////    UITableViewController  *tableViewController = [[UITableViewController alloc]init];
////    tableViewController.tableView = self.tableView;
//    
////    tableViewController.refreshControl = [[UIRefreshControl alloc]init];
//    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
////    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to refresh"]
////    controller.refreshControl.attributedTitle = [NSAttributedString];
//    
//    [refreshControl addTarget:self action:@selector(getDataFromApi) forControlEvents:UIControlEventValueChanged];
//    self.
//    

}

- (void) loadThumbnailForUrl: (NSString *) url {
    
}

- (void) checkNetwork {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
