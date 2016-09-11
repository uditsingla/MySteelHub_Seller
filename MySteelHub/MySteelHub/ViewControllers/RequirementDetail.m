//
//  RequirementDetail.m
//  MySteelHub
//
//  Created by Apple on 08/05/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementDetail.h"

@interface RequirementDetail ()
{
    
    __weak IBOutlet UILabel *requiredbyDate;
    __weak IBOutlet UILabel *approxOrderValue;
    __weak IBOutlet UILabel *rate;
    __weak IBOutlet UILabel *preferredBrands;
    __weak IBOutlet UILabel *type;
    __weak IBOutlet UILabel *Quantity;
    
    __weak IBOutlet UILabel *gradeRequired;
    
    __weak IBOutlet UILabel *length;
    __weak IBOutlet UILabel *testCertRequired;
    __weak IBOutlet UILabel *chemical;
    __weak IBOutlet UILabel *physical;
}

@end

@implementation RequirementDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleLabel:@"REQUIREMENT DETAILS"];
    [self setMenuButton];
    [self setBackButton];

    chemical.layer.borderWidth=1;
    chemical.layer.borderColor=[UIColor blackColor].CGColor ;
    physical.layer.borderWidth=1;
    physical.layer.borderColor=[UIColor blackColor].CGColor ;
    testCertRequired.layer.borderWidth=1;
    testCertRequired.layer.borderColor=[UIColor blackColor].CGColor ;
    requiredbyDate.layer.borderWidth=1;
    requiredbyDate.layer.borderColor=[UIColor blackColor].CGColor ;
    Quantity.layer.borderWidth=1;
    Quantity.layer.borderColor=[UIColor blackColor].CGColor ;gradeRequired.layer.borderWidth=1;
    gradeRequired.layer.borderColor=[UIColor blackColor].CGColor ;
    length.layer.borderWidth=1;
    length.layer.borderColor=[UIColor blackColor].CGColor ;
    type.layer.borderWidth=1;
    type.layer.borderColor=[UIColor blackColor].CGColor ;
    rate.layer.borderWidth=1;
    rate.layer.borderColor=[UIColor blackColor].CGColor ;
    preferredBrands.layer.borderWidth=1;
    preferredBrands.layer.borderColor=[UIColor blackColor].CGColor ;
    approxOrderValue.layer.borderWidth=1;
    approxOrderValue.layer.borderColor=[UIColor blackColor].CGColor ;
//    chemical.layer.borderWidth=1;
//    chemical.layer.borderColor=[UIColor blackColor].CGColor ;chemical.layer.borderWidth=1;
//    chemical.layer.borderColor=[UIColor blackColor].CGColor ;
    
}

- (IBAction)btnDescription:(id)sender {
}
- (IBAction)btnOptionFromSeller:(id)sender {
}

-(void)settings
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    //    NSString *string=[[NSString alloc]init];
    
    UIAlertAction *button = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action){
                                                       //add code to make something happen once tapped
                                                   }];
    
    //
    [actionSheet addAction:button];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"Change Password",@"Contact Us",@"Logout" ,nil];
    for (int i=0; i<arr.count; i++) {
        
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[arr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            if ([action.title isEqualToString:@"Change Password"]) {
                //
            }
            if ([action.title isEqualToString:@"Contact Us"]) {
                //
            }
            
            if ([action.title isEqualToString:@"Logout"]) {
                //
            }
            
            
            
            
            // Cancel button tappped do nothing.
            
        }]];
    }
    //
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
}
-(void)Back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
