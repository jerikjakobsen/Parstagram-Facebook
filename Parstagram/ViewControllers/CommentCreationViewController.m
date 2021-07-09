//
//  CommentCreationViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/8/21.
//

#import "CommentCreationViewController.h"
#import "Comment.h"

@interface CommentCreationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end

@implementation CommentCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.commentTextView becomeFirstResponder];
    self.commentTextView.layer.borderWidth = 1;
    self.commentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    // Do any additional setup after loading the view.
}
- (IBAction)didSendComment:(id)sender {
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.postID = self.postID;
    newComment.text = self.commentTextView.text;
    if (newComment.text != nil && newComment.text.length > 5) {
        [newComment postComment:^(BOOL succeeded, NSError * _Nullable error) {
            if (error == nil) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"%@", error);
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
