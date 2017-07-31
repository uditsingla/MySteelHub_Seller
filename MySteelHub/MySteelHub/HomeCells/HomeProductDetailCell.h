//
//  HomeProductDetailCell.h
//  MySteelHub
//
//  Created by Apple on 19/07/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeProductDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblPreferedBrands;
@property (weak, nonatomic) IBOutlet UILabel *lblGraderequired;
@property (weak, nonatomic) IBOutlet UILabel *lblRequiredByDate;
@property (weak, nonatomic) IBOutlet UITextField *txtDeliveryCity;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryState;
@property (weak, nonatomic) IBOutlet UITextField *txtBudget;
@property (weak, nonatomic) IBOutlet UILabel *lblPreferedTax;
    
@property (weak, nonatomic) IBOutlet UISwitch *switchPhysical;
@property (weak, nonatomic) IBOutlet UISwitch *switchChemical;
@property (weak, nonatomic) IBOutlet UISwitch *switchCertReq;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtControlLenghtRequired;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtControlTypeRequired;

@end
