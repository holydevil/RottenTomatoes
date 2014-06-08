//
//  MovieTableViewCell.h
//  
//
//  Created by Praveen P N on 6/6/14.
//
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tomatometerImage;
@property (weak, nonatomic) IBOutlet UILabel *tomatometerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *audienceImage;
@property (weak, nonatomic) IBOutlet UILabel *audienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRatingLabel;

@end
