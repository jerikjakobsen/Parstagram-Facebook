//
//  ProfileCell.h
//  Parstagram
//
//  Created by johnjakobsen on 7/9/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *contentImage;
@property Post *post;
@end

NS_ASSUME_NONNULL_END
