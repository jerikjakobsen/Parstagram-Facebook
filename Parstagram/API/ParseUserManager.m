//
//  ParseUserManager.m
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import "ParseUserManager.h"
#import <Parse/Parse.h>

@implementation ParseUserManager
+ (void) registerUser: (NSString *) username password: (NSString *) password completion: (void (^)(NSError *)) completion {
    PFUser *newUser = [PFUser user];
    newUser.username = username;
    newUser.password = password;
    if (username.length > 0 && password.length >0) {

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"User signup failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User Sign up Successful");
            }
            completion(error);
    }];
        
    } else {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject: @"Username and/or Password cannot be empty" forKey: NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain: @"com.JohnJakobsen.Parstagram.ErrorDomain" code: 1 userInfo: userInfo];

        completion(error);
    }
}

+ (void) loginUser: (NSString *) username password: (NSString *) password completion: (void (^)(NSError *)) completion {
    if (username.length > 0 && password.length >0) {
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User login successful");
            }
        completion(error);
    }];
        
    }
}

+ (void) logoutUser: (void (^)(NSError *)) completion {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"User log out failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User log out successful");
            }
        completion(error);
    }];
}

@end
