//
//  BoxOfficeViewController.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "BoxOfficeViewController.h"
#import "MovieTableViewCell.h"

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
    [self loadDefaults];
    [self getDataFromApi];
    
    self.tableView.rowHeight = 97;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void) getDataFromApi {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6h3yq9mnqksypq27xzkwz9ww";
//    id jsonObj;
//    NSDictionary *jsonDictionary = [[NSDictionary alloc]init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.moviesData = [object objectForKey:@"movies"];
        
        NSLog(@"total enties are %d", self.moviesData.count);
        [self.tableView reloadData];
        
    }];
    
}

- (void) loadDefaults {
    self.title = @"Box Office";
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.moviesData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    
    NSDictionary *movies = self.moviesData[indexPath.row];
    NSLog(@"title = %@ and synopsis = %@", movies[@"title"],movies[@"synopsis"]);
    
    cell.movieTitleLabel.text = movies[@"title"];
    cell.movieSynopsisLabel.text = movies[@"synopsis"];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
