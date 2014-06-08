//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Praveen P N on 6/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *movieScrollView;
@property NSDictionary *movieData;
@end
