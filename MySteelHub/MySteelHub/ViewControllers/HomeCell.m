//
//  HomeCell.m
//  MySteelHub
//
//  Created by Amit Yadav on 05/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    keyboardDoneButtonView.barStyle = UIBarStyleBlackOpaque;

    [keyboardDoneButtonView setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [keyboardDoneButtonView setBackgroundColor:kBlueColor];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace,doneButton, nil]];
    
    _txtFieldQuantity.inputAccessoryView = keyboardDoneButtonView;
    
    _txtFieldInitialUnitPrice.inputAccessoryView = keyboardDoneButtonView;

    _txtFieldBargainUnitPrice.inputAccessoryView = keyboardDoneButtonView;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.superview endEditing:YES];
}

@end
