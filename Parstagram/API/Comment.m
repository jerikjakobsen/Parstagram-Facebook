//
//  Comment.m
//  Parstagram
//
//  Created by johnjakobsen on 7/7/21.
//

#import "Comment.h"
#import <Parse/Parse.h>
#import "Post.h"

@implementation Comment
@dynamic commentID;
@dynamic postID;
@dynamic author;
@dynamic text;
+ (nonnull NSString *)parseClassName {
    return @"Comment";
}
- (void) postComment: (PFBooleanResultBlock  _Nullable)completion {
    PFQuery *query = [Post query];
    [query getObjectInBackgroundWithId:self.postID block:^(PFObject * _Nullable postObject, NSError * _Nullable error) {
        Post *post = (Post *) postObject;
        post.commentCount = @([post.commentCount intValue] + 1);
        [post saveInBackground];
    }];
    [self saveInBackgroundWithBlock: completion];
}




@end
