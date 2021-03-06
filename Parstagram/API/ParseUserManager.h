//
//  ParseUserManager.h
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseUserManager : NSObject
+ (void) getUserPosts: (PFUser *) user completion: (void (^)(NSArray *, NSError *)) completion;
+ (void) registerUser: (NSString *) username
           password: (NSString *) password
           profilePic: (UIImage *) profilePic
           completion: (void (^)(NSError *)) completion;

+ (void) loginUser: (NSString *) username password: (NSString *) password completion: (void (^)(NSError *)) completion;
+ (void) logoutUser: (void (^)(NSError *)) completion;
@end

NS_ASSUME_NONNULL_END
