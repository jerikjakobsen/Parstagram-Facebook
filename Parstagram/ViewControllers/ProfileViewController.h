//
//  ProfileViewController.h
//  Parstagram
//
//  Created by johnjakobsen on 7/9/21.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property PFUser *user;
@end

NS_ASSUME_NONNULL_END
