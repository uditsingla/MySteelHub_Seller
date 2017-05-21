//
//  SignUP.h
//  MySteelHub
//
//  Created by Abhishek Singla on 02/04/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SignUP : BaseViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UIScrollView *_scrollView;

    __weak IBOutlet UITextField *_txtFieldUsername;
    __weak IBOutlet UITextField *_txtFieldPassword;
    __weak IBOutlet UITextField *_txtFieldConfirmPass;
    
    __weak IBOutlet UITextField *_txtFieldCompanyName;
    __weak IBOutlet UITextField *_txtFieldEmail;
    
    __weak IBOutlet UITextField *_txtFieldAddress;
    __weak IBOutlet UITextField *_txtFieldCity;
    __weak IBOutlet UITextField *_txtFieldState;
    __weak IBOutlet UITextField *_txtFieldZipCode;
    __weak IBOutlet UITextField *_txtFieldContact;
    __weak IBOutlet UITextField *_txtFieldTin;
    __weak IBOutlet UITextField *_txtFieldPan;


    __weak IBOutlet UITextField *_txtFieldBrand;
    __weak IBOutlet UITextField *_txtFieldExpected;
    
    __weak IBOutlet UIButton *btnSubmit;

    
    
    UIView *pickerPreferredBrandsView;


}
@property(nonatomic,assign) BOOL isEditProfile;

@end
