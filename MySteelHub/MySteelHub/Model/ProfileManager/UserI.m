//
//  UserI.m
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "UserI.h"

@implementation UserI

@synthesize userID,name,email,address,city,state,zip,contactNo,companyName,customerType,expectedQuantity,latitude,longitude,pan,role,tin,brands;

- (id)init
{
    self = [super init];
    if (self) {
        userID = @"";
        name = @"";
        email = @"";
        address = @"";
        city = @"";
        state = @"";
        zip = @"";
        contactNo = @"";
        companyName = @"";
        customerType = [NSMutableArray new];
        expectedQuantity = @"";
        latitude = 0;
        longitude = 0;
        pan = @"";
        role = @"";
        tin = @"";

        brands = [NSMutableArray new];
    }
    return self;
}


@end
