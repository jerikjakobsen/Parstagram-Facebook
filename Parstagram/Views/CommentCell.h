//
//  CommentCell.h
//  Parstagram
//
//  Created by johnjakobsen on 7/8/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *CommentText;

@end

NS_ASSUME_NONNULL_END
