//
//  Comment.h
//  Parstagram
//
//  Created by johnjakobsen on 7/7/21.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Comment.h"
NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *text;

- (void) postComment: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
