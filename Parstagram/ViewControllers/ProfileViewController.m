//
//  ProfileViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/9/21.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "ParseUserManager.h"
#import "Post.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property NSArray *posts;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.user == nil) {
        self.user = [PFUser currentUser];
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.profileImageView.file = self.user[@"profile_image"];
    [self.profileImageView loadInBackground];
    self.usernameLabel.text = self.user.username;
    [ParseUserManager getUserPosts:self.user completion:^(NSArray * _Nonnull data, NSError * _Nonnull error ) {
        if (error != nil) NSLog(@"%@", error.localizedDescription);
        else {
            NSLog(@"%@", data);
            self.posts = data;
            [self.collectionView reloadData];

        }
    }];

    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [ParseUserManager getUserPosts:self.user completion:^(NSArray * _Nonnull data, NSError * _Nonnull error ) {
        if (error != nil) NSLog(@"%@", error.localizedDescription);
        else {
            NSLog(@"%@", data);
            self.posts = data;
            [self.collectionView reloadData];

        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.contentImage.file = post.image;
    [cell.contentImage loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
        cell.contentImage.image = [self resizeImage:image withSize:CGSizeMake(self.collectionView.frame.size.width/3, self.collectionView.frame.size.width/ 3 * 1.5)];
    }];
    cell.post = post;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
