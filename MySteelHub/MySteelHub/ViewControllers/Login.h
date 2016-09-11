//
//  Login.h
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"

@interface Login : UIViewController<UITextFieldDelegate>
{
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UIButton *btnSignUp;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UIButton *btnCheckBox;
    __weak IBOutlet UILabel *lblTerms;
    __weak IBOutlet UIButton *btnCreateAccount;
    __weak IBOutlet UILabel *lblAgreePrivacyPolicy;
    __weak IBOutlet UIScrollView *scrollview;
}

-(IBAction)loginUser:(id)sender;
-(IBAction)signUpUser:(id)sender;
-(IBAction)forgotPassword:(id)sender;

@end
