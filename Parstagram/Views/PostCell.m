//
//  PostCell.m
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import "PostCell.h"
#import <Parse/PFImageView.h>
#import "DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tappedAddComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellWasSelected:)];
    [self.addCommentView addGestureRecognizer:tappedAddComment];
    tappedAddComment.delegate = self;
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setPost: (Post *) post {
    self.cPost = post;
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString: [post.author.username stringByAppendingString: @" "] ];
    NSMutableAttributedString *caption = [[NSMutableAttributedString alloc] initWithString:post.caption];
    [username addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: 17] range:NSMakeRange(0, username.length)];
    [username appendAttributedString: caption];
    self.captionLabel.attributedText = username;
    self.dateLabel.text = self.cPost.createdAt.timeAgoSinceNow;
    self.likesCount.text = [NSString stringWithFormat:@"Liked by %@", post.likeCount];
    self.usernameLabel.text = post.author.username;
    self.profilePic.file = post.author[@"profile_image"];
    self.currentUserProfilePic.file = [PFUser currentUser][@"profile_image"];
    [self.currentUserProfilePic loadInBackground];
    [self.profilePic loadInBackground];
    self.mainPostImageView.file = post.image;
    [self.mainPostImageView loadInBackground];
    [self.cPost getLastComment:^(Comment * comment) {
        if (comment != nil) {
        NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString: [comment.author.username stringByAppendingString: @" "] ];
        NSMutableAttributedString *caption = [[NSMutableAttributedString alloc] initWithString:comment.text];
        [username addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: 17] range:NSMakeRange(0, username.length)];
        [username appendAttributedString: caption];
        self.featuredCommentLabel.attributedText = username;
        }
    }];
}
- (IBAction)didLike:(id)sender {

    [self.cPost likePost:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) NSLog(@"%@", error.localizedDescription);
        [self.likeButton setSelected: YES];
        self.likesCount.text = [NSString stringWithFormat:@"Liked by %@", self.cPost.likeCount];

    }];
}

- (void) cellWasSelected: (UITapGestureRecognizer *) sender {
    [self.delegate tappedCell:self.cPost];
}
@end


