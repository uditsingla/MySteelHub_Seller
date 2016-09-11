//
//  HomeCell.h
//  MySteelHub
//
//  Created by Amit Yadav on 05/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface HomeCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txtFieldDiameter;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldQuantity;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end
