//
//  PostCell.h
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/PFImageView.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PostCellDelegate

- (void) addComment: (Post *) post;
- (void) goToUser: (PFUser *) user;

@end

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *featuredCommentLabel;
@property (weak, nonatomic) IBOutlet PFImageView *mainPostImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *addCommentView;

@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet PFImageView *currentUserProfilePic;
@property (nonatomic, weak) id<PostCellDelegate> delegate;
@property Post *cPost;
- (void) setPost: (Post *) post;

@end

NS_ASSUME_NONNULL_END
