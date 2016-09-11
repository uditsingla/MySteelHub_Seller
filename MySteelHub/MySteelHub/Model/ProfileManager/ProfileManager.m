//
//  ProfileManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "ProfileManager.h"

@implementation ProfileManager
@synthesize owner;

- (id)init
{
    self = [super init];
    if (self) {
        
        owner = [UserI new];
    }
    return self;
}


@end
