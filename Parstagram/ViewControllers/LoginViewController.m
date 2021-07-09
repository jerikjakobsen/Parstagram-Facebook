//
//  LoginViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import "LoginViewController.h"
#import "ParseUserManager.h"


@interface LoginViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) UIAlertController* alert;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didLogin:(id)sender {
    [ParseUserManager loginUser: self.usernameField.text password: self.passwordField.text completion:^(NSError * _Nonnull error) {
        if (error != nil) {
            if (error.code == 1) {
                // Must not be empty
                self.alert = [UIAlertController alertControllerWithTitle:@"Must not be empty" message:@"Username or Password must not be empty" preferredStyle: UIAlertControllerStyleAlert];

                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler: nil];
                [self.alert addAction: okAction];
                [self presentViewController:self.alert animated:YES completion:nil];
            } else {
                self.alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Something went wrong, please try again" preferredStyle: UIAlertControllerStyleAlert];

                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler: nil];
                [self.alert addAction: okAction];
                [self presentViewController:self.alert animated:YES completion:nil];
            }
        } else {
            [self performSegueWithIdentifier:@"LoginToHome" sender:nil];
        }
    }];
}
- (IBAction)didSignup:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(200, 200)];

    [ParseUserManager registerUser: self.usernameField.text password: self.passwordField.text profilePic: resizedImage completion:^(NSError * _Nonnull error) {
        if (error != nil) {
            if (error.code == 1) {
                // Must not be empty
                self.alert = [UIAlertController alertControllerWithTitle:@"Must not be empty" message:@"Username or Password must not be empty" preferredStyle: UIAlertControllerStyleAlert];

                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler: nil];
                [self.alert addAction: okAction];
                [self presentViewController:self.alert animated:YES completion:nil];
            } else {
                self.alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Something went wrong, please try again" preferredStyle: UIAlertControllerStyleAlert];

                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler: nil];
                [self.alert addAction: okAction];
                [self presentViewController:self.alert animated:YES completion:nil];
            }
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                [self performSegueWithIdentifier:@"LoginToHome" sender:nil];
            }];
            
        }
    }];
}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
