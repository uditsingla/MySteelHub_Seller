//
//  ForgotPassword.m
//  MySteelHub
//
//  Created by Abhishek Singla on 09/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "ForgotPassword.h"

@interface ForgotPassword ()
{
    
    __weak IBOutlet UITextField *txtEmail;
}
@end

@implementation ForgotPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitleLabel:@"Forgot Password"];
    [self setBackButton];
    
    
    //Custom UI for TextFilds
    [self customtxtfield:txtEmail withrightIcon:nil borderLeft:true borderRight:true borderBottom:true borderTop:true];
    
    [txtEmail setValue:[UIColor lightGrayColor]
            forKeyPath:@"_placeholderLabel.textColor"];
}


-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)clkSubmit:(id)sender {
    
    if([self validateData])
    {
        //hit webservice
        
        NSDictionary *dictData = [NSDictionary dictionaryWithObjectsAndKeys:txtEmail.text,@"email", nil];
        
        [model_manager.loginManager recoverPassword:dictData completion:^(NSDictionary *json, NSError *error) {
            
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
    
    NSString *value = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([value length] == 0)
    {
        return false;
        
    }
    
    if(![self validEmail:txtEmail.text])
    {
        return false;
        
    }
    return true;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
