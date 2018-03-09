//
//  Login.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Login.h"
#import "LoginManager.h"

@interface Login ()
{
    UIStoryboard *mainStoryboard;
    UIViewController *loginController;
    NSMutableDictionary *dictLoginParams;
    
}
@end

@implementation Login




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    txtEmail=[self customtxtfield:txtEmail withplaceholder:@"Email"withIcon:[UIImage imageNamed:@"user.png"]];
    txtPassword=[self customtxtfield:txtPassword withplaceholder:@"Password" withIcon:[UIImage imageNamed:@"password.png"]];
    
    //    txtEmail.text = @"xyz@gmail.com";
    //    txtPassword.text = @"aaaaaaaa";
    //    
    //[txtUsername setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    //    txtEmail.placeholder = @"Email";
    //    txtEmail.text = @"Email";
    //    
    
    
    //[txtEmail setValue:[UIColor colorWithRed:97.0/255.0 green:1.0/255.0 blue:17.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    //dictLoginParams = [NSMutableDictionary new];
    
    //    UIColor *color = [UIColor whiteColor];
    //    txtEmail.attributedPlaceholder =
    //    [[NSAttributedString alloc]
    //     initWithString:@"Username"
    //     attributes:@{NSForegroundColorAttributeName:color}];3
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isAutoLogin"])
    {
        model_manager.profileManager.owner.userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
        [self callSlideMenu];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    
    self.navigationController.navigationBar.hidden=YES;
    /*
     BOOL isUserAuthorised = TRUE;
     if (isUserAuthorised)
     {
     Home *homeVC =  [kMainStoryboard instantiateInitialViewController];
     [self.navigationController pushViewController:homeVC animated:YES];
     }
     */
}
- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods -
-(IBAction)loginUser:(id)sender
{
    
    if ([self validEmail:txtEmail.text] != 0 && [[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0 )
    {
        [SVProgressHUD show];
        
        dictLoginParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password",@"ios",@"device_type",@"seller",@"role", [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceToken"],@"device_token",nil];
        
        //dictLoginParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password", @"ios",@"device_type",  @"1234567890",@"device_token",nil];
        
        
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        [model_manager.loginManager userLogin:dictLoginParams completion:^(NSArray *addresses, NSError *error){
            NSLog(@"Login Response");
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            if (error) {
                
                [self appError:@"" jsonerror:[addresses objectAtIndex:0]];
                return ;
            }
            else
            {
                
                //                UIViewController *Requirements = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Detail"];
                //                [self.navigationController pushViewController:Requirements animated:YES];
                [self callSlideMenu];
                
            }
            
            
        }];
        
    }
    else
    {
        [self appError:@"email or password" jsonerror:@""];
        
    }
    
}


-(void)callSlideMenu
{
    UIViewController *homeviewController;
    homeviewController = [kMainStoryboard instantiateViewControllerWithIdentifier: @"Requirements"];
    
    UIViewController *leftSlider = [kMainStoryboard instantiateViewControllerWithIdentifier: @"leftslider"];
    
    UINavigationController *centerNavigationController=[[UINavigationController alloc]initWithRootViewController:homeviewController];
    centerNavigationController.navigationBarHidden=YES;
    
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:centerNavigationController
                                                    leftMenuViewController:nil
                                                    rightMenuViewController:leftSlider];
    
    [container setPanMode:MFSideMenuPanModeNone];
    appdelegate.container = container;
    //appdelegate.window.rootViewController = container;
    [appdelegate initializeInAppNotificationView];
    
    [self.navigationController pushViewController:container animated:YES];
}



-(void)appError:(NSString*)appError jsonerror:(NSString*)jsonerror
{
    if ([appError isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",jsonerror] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        
        // Present action sheet.
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"Please enter a valid %@",appError] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        
        // Present action sheet.
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    
    
    
}


-(void)keyboardWillShow:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, kbSize.height, 0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;
    
    
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0,0, 0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;
    
    
}


-(IBAction)signUpUser:(id)sender
{
    UIViewController *signUpVc = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"signUp"];
    [self.navigationController pushViewController:signUpVc animated:YES];
    
}


-(IBAction)forgotPassword:(id)sender
{
    NSLog(@"Forgot Password");
    UIViewController *forgotPasswordVc = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"forgotpassword"];
    [self.navigationController pushViewController:forgotPasswordVc animated:YES];
    
}


-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

-(UITextField*)customtxtfield:(UITextField*)txtField withplaceholder:(NSString*)placeholder withIcon:(UIImage*)image
{
    txtField.backgroundColor = [UIColor clearColor];
    txtField.attributedPlaceholder = [[NSAttributedString alloc]
                                      initWithString:placeholder
                                      attributes:@{NSForegroundColorAttributeName:
                                                       [UIColor lightGrayColor]}];
    
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    paddingView.backgroundColor=[UIColor clearColor];
    UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(12, paddingView.frame.size.height/2-8, 16, 16)];
    icon.image=image;
    [paddingView addSubview:icon];
    txtField.leftView = paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, txtField.frame.size.height-2, self.view.frame.size.width - 76, 2)];
    lineView.backgroundColor = [UIColor whiteColor];
    [txtField addSubview:lineView];
    
    return txtField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtEmail) {
        [textField resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    return YES;
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
