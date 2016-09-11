//
//  ChangePassword.m
//  MySteelHub
//
//  Created by Abhishek Singla on 09/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "ChangePassword.h"

@interface ChangePassword ()
{
    
    __weak IBOutlet UITextField *txtOldPassword;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtConfirmPassword;
    
    
}
@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleLabel:@"Change Password"];
    [self setMenuButton];
    [self setBackButton];
    
    
    
    //Custom UI for TextFilds
    [self customtxtfield:txtOldPassword withrightIcon:nil borderLeft:true borderRight:true borderBottom:nil borderTop:true];
    
    [txtOldPassword setValue:[UIColor lightGrayColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    //Custom UI for TextFilds
    [self customtxtfield:txtPassword withrightIcon:nil borderLeft:true borderRight:true borderBottom:nil borderTop:true];
    
    [txtOldPassword setValue:[UIColor lightGrayColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    //Custom UI for TextFilds
    [self customtxtfield:txtConfirmPassword withrightIcon:nil borderLeft:true borderRight:true borderBottom:true borderTop:true];
    
    [txtConfirmPassword setValue:[UIColor lightGrayColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clkSubmit:(id)sender {
    
    
    if ([self validateData]) {
        
        NSDictionary *dictData = [NSDictionary dictionaryWithObjectsAndKeys:txtOldPassword.text,@"old_password",txtPassword.text,@"new_password",@"123",@"user_id", nil];
        
        [model_manager.loginManager changePassword:dictData completion:^(NSDictionary *json, NSError *error) {
            if (error == nil) {
                
                NSLog(@"json Response change apasseword : %@",json);
                
            }
            else
            {
                NSLog(@"Error Response change apasseword : %@",error);
                
            }
            
        }];
        
    }
}

-(BOOL)validateData
{
    NSString *value = [txtOldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([value length] == 0)
    {
        
        NSLog(@"Please Enter old password");
        
        return false;
        
    }
    
    
    value = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if([value length] == 0)
    {
        
        NSLog(@"Please enter password");
        
        return false;
        
    }
    
    value = [txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if([value length] == 0)
    {
        
        NSLog(@"Please enter confirm password");
        
        return false;
        
    }
    
    
    if (![txtConfirmPassword.text isEqualToString:txtPassword.text]) {
        
        NSLog(@"Password does not match");
        
        return false;
    }
    
    return true;
    
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
