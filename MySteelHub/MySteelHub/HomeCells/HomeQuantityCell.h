//
//  HomeQuantityCell.h
//  MySteelHub
//
//  Created by Apple on 19/07/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"


@interface HomeQuantityCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *txtSize;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;
    
@end
