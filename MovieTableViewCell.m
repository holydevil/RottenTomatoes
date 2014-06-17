//
//  MovieTableViewCell.m
//  
//
//  Created by Praveen P N on 6/6/14.
//
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMovieCellDetails: (NSDictionary *) movie  {
    NSLog(@"data in the setMoviewCellDetails function is %@", movie);
}

@end
