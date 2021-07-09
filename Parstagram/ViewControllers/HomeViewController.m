//
//  HomeViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import "HomeViewController.h"
#import "ParseUserManager.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "DetailViewController.h"
#import "CommentCreationViewController.h"
#import "ProfileViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, PostCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.posts = [[NSArray alloc] init];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(fetchPosts:) forControlEvents:UIControlEventValueChanged];

    [self.homeTableView insertSubview:refreshControl atIndex:0];


    // Do any additional setup after loading the view.
    [self fetchPosts];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.navigationController setNavigationBarHidden: TRUE];
    [self fetchPosts];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"toDetail"]) {
        DetailViewController *DetailVC = segue.destinationViewController;
        PostCell *pcell = sender;
        DetailVC.post = pcell.cPost;
    }
}


- (void) fetchPosts {
    [Post getLastPosts:^(NSArray * posts) {
        self.posts = posts;
        [self.homeTableView reloadData];
    }];
}

- (void) fetchPosts: (UIRefreshControl *) refreshControl {
    [Post getLastPosts:^(NSArray * posts) {
        self.posts = posts;
        [self.homeTableView reloadData];
        [refreshControl endRefreshing];
    }];
}

- (IBAction)didLogout:(id)sender {
    [ParseUserManager logoutUser:^(NSError * _Nonnull error) {
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Something went wrong, please try again" preferredStyle: UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler: nil];
            [alert addAction: okAction];
            [self presentViewController: alert animated:YES completion:nil];
        } else {
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavController"];
            myDelegate.window.rootViewController = loginVC;

        }
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.delegate = self;
    [cell setPost: self.posts[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.posts == nil) return 0;
    return self.posts.count;
}
- (IBAction)didTapAddComment:(id)sender {
    NSLog(@"%@", sender);
}

- (void) addComment: (Post *) post {
    [self performSegueWithIdentifier:@"HomeToCreation" sender:self];
    CommentCreationViewController *CommentVC = (CommentCreationViewController *) self.navigationController.topViewController ;
    CommentVC.postID = [post objectId];
}

- (void) goToUser:(PFUser *)user {
    
    [self performSegueWithIdentifier:@"HomeToProfile" sender:self];
    ProfileViewController *profileVC = (ProfileViewController *) self.navigationController.topViewController;
    profileVC.user = user;
    
}
@end
