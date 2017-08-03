//
//  HomeBargainCell.h
//  MySteelHub
//
//  Created by Apple on 31/07/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBargainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txtBargainAmount;
@property (weak, nonatomic) IBOutlet UISwitch *isBargainRequired;

@end
