//
//  BaseViewController.h
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)setTitleLabel:(NSString*)title;
-(void)setBackButton;
-(void)setMenuButton;

-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image borderLeft:(BOOL)l borderRight:(BOOL)r borderBottom:(BOOL)b borderTop:(BOOL)t;

@end
