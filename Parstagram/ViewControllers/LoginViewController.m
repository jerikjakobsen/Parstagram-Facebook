//
//  LoginViewController.m
//  Parstagram
//
//  Created by johnjakobsen on 7/6/21.
//

#import "LoginViewController.h"
#import "ParseManager.h"

@interface LoginViewController ()
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
    [ParseManager loginUser: self.usernameField.text password: self.passwordField.text completion:^(NSError * _Nonnull error) {
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
    [ParseManager registerUser: self.usernameField.text password: self.passwordField.text completion:^(NSError * _Nonnull error) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
