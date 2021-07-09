//
//  DetailViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/8/21.
//

#import "DetailViewController.h"
#import <Parse/PFImageView.h>
#import "Post.h"
#import "CommentCell.h"
#import "Comment.h"
#import "CommentCreationViewController.h"


@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet PFImageView *authorProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *currentUserImageView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property NSArray *comments;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    if (self.post != nil) {
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString: [self.post.author.username stringByAppendingString: @" "] ];
    NSMutableAttributedString *caption = [[NSMutableAttributedString alloc] initWithString:self.post.caption];
    [username addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: 17] range:NSMakeRange(0, username.length)];
    [username appendAttributedString: caption];
    self.captionLabel.attributedText = username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"Liked by %@", self.post.likeCount];
    self.usernameLabel.text = self.post.author.username;
    self.authorProfileImageView.file = self.post.author[@"profile_image"];
    self.currentUserImageView.file = [PFUser currentUser][@"profile_image"];
    [self.authorProfileImageView loadInBackground];
    [self.currentUserImageView loadInBackground];
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
        [self fetchComments];
    }
}

- (void) fetchComments {
    [self.post getLastComments:^(NSArray * comments) {
            self.comments = comments;
        [self.commentsTableView reloadData];
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailToCreation"]) {
        CommentCreationViewController *CommentVC = segue.destinationViewController;
        CommentVC.postID = [self.post objectId];
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CommentCell *cell = [self.commentsTableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    Comment *comment = self.comments[indexPath.row];
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString: [comment.author.username stringByAppendingString: @" "] ];
    NSMutableAttributedString *caption = [[NSMutableAttributedString alloc] initWithString:comment.text];
    [username addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: 17] range:NSMakeRange(0, username.length)];
    [username appendAttributedString: caption];
    cell.CommentText.attributedText = username;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}
- (IBAction)didTapCreateComment:(id)sender {
    [self performSegueWithIdentifier: @"DetailToCreation" sender:self];
    
}

@end
