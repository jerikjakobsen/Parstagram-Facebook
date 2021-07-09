//
//  Post.m
//  Parstagram
//
//  Created by johnjakobsen on 7/7/21.
//

#import "Post.h"
#import "Comment.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DateTools.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

+ (void) getLastPosts: ( void (^)(NSArray *) ) completion {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query includeKey: @"author"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts == nil) NSLog(@"%@", error.localizedDescription);
        completion(posts);
    }];
    

}

- (void) likePost: (PFBooleanResultBlock  _Nullable) completion {
    self.likeCount = @(self.likeCount.intValue + 1);
    [self saveInBackgroundWithBlock:completion];
}

- (void) commentOnPost: (NSString *) comment withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.postID = [self objectId];
    newComment.text = comment;
    [newComment postComment: completion];
}
- (void) getLastComment: ( void (^)(Comment *) ) completion {
    PFQuery *query = [PFQuery queryWithClassName: @"Comment"];
    [query whereKey:@"postID" matchesText:  [self objectId]];
    [query includeKey:@"author"];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable comments, NSError * _Nullable error) {
        if (error != nil) NSLog(@"%@", error.localizedDescription);
        if (comments != nil) {
            if (comments.count > 0) completion((Comment *) comments[0]);
                else completion(nil);
        } else completion(nil);
    }];
}


- (void) getLastComments: ( void (^)(NSArray *) ) completion {
    PFQuery *query = [PFQuery queryWithClassName: @"Comment"];
    [query whereKey:@"postID" matchesText:[self objectId] ];
    [query includeKey:@"author"];

    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable comments, NSError * _Nullable error) {
        if (error != nil) NSLog(@"%@", error.localizedDescription);
        completion(comments);
    }];
}

@end
