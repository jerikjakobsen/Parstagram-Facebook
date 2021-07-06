//
//  ParseManager.h
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseManager : NSObject
+ (void) registerUser: (NSString *) username password: (NSString *) password completion: (void (^)(NSError *)) completion;
+ (void) loginUser: (NSString *) username password: (NSString *) password completion: (void (^)(NSError *)) completion;
@end

NS_ASSUME_NONNULL_END
