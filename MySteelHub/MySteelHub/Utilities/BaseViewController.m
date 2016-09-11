//
//  BaseViewController.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 70);
    topView.backgroundColor = [UIColor colorWithRed:8/255.0 green:188/255.0 blue:211/255.0 alpha:1];
    [self.view addSubview:topView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitleLabel:(NSString*)title
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    label.text = title;
    label.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

-(void)setBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 50, 50);
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)setMenuButton
{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(self.view.frame.size.width-50, 20, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(rightMenuAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:menuButton];
}



#pragma mark - Clk Actions

-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightMenuAction
{
    NSLog(@"right menu pressed");
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
    
}


#pragma mark - custom textfield

-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image borderLeft:(BOOL)l borderRight:(BOOL)r borderBottom:(BOOL)b borderTop:(BOOL)t
{
    
    UITextField *tf = txtField;
    tf.frame = CGRectMake(tf.frame.origin.x, tf.frame.origin.y
                          , self.view.frame.size.width-20, 40);
    
    NSLog(@"self frame : %f",self.view.frame.size.width);
    
    float wid = (self.view.frame.size.width-20)/2;
    
    if ((txtField.tag == 1) || (txtField.tag == 3))
    {
        
        tf.frame = CGRectMake(tf.frame.origin.x, tf.frame.origin.y
                              , wid, 40);
        
    }
    if ((txtField.tag == 2) || (txtField.tag == 4))
    {
        tf.frame = CGRectMake(wid, tf.frame.origin.y
                              , wid, 40);
    }
    
    
    CGFloat borderWidth = 1;
    UIColor *graycolor = [UIColor lightGrayColor];
    
    
    CGFloat custWidth = txtField.frame.size.width;
    CGFloat custHeight = 40;
    
    //    CGFloat custWidth = self.view.frame.size.width-20;
    //    CGFloat custHeight = 40;
    
    
    //Top Border
    if (t) {
        
        CALayer *border = [CALayer layer];
        border.borderColor = graycolor.CGColor;
        border.frame = CGRectMake(0, 0, custWidth, custHeight);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
        
    }
    
    //Bottom border
    if (b) {
        CALayer *border = [CALayer layer];
        border.borderColor = graycolor.CGColor;
        border.frame = CGRectMake(0, custHeight - borderWidth, custWidth, custHeight);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
        
    }
    //
    
    //right border
    if (r) {
        CALayer *rightBorder = [CALayer layer];
        rightBorder.frame = CGRectMake(custWidth - 1, 0, 1, custHeight);
        rightBorder.borderColor = graycolor.CGColor;
        rightBorder.borderWidth = borderWidth;
        [txtField.layer addSublayer:rightBorder];
        
    }
    
    
    //left border
    if (l) {
        CALayer *leftBorder = [CALayer layer];
        leftBorder.frame = CGRectMake(0, 0, 1, custHeight);
        leftBorder.borderColor = graycolor.CGColor;
        leftBorder.borderWidth = borderWidth;
        [txtField.layer addSublayer:leftBorder];
    }
    
    
    
    //    if ((txtField.tag == 1) || (txtField.tag == 3)) {
    //        
    //    }
    //    
    //    if ((txtField.tag == 2) || (txtField.tag == 4)){
    //        
    //    }
    //    
    
    //txtField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 41)];
    paddingView.backgroundColor=[UIColor clearColor];
    txtField.leftView=paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    //txtField.layer.borderWidth= 1.0f;
    UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(custWidth-25, custHeight/2-6, 16, 16)];
    icon.image=image;
    [txtField addSubview:icon];
    
    txtField.delegate = self;
    
    return txtField;
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
