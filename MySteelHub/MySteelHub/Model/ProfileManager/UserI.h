//
//  UserI.h
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserI : NSObject

@property(strong,nonatomic) NSString *userID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *zip;
@property(strong,nonatomic) NSString *contactNo;
@property(strong,nonatomic) NSString *companyName;
@property(strong,nonatomic) NSMutableArray *customerType;
@property(strong,nonatomic) NSString *expectedQuantity;
@property(assign,nonatomic) double latitude;
@property(assign,nonatomic) double longitude;
@property(strong,nonatomic) NSString *pan;
@property(strong,nonatomic) NSString *role;
@property(strong,nonatomic) NSString *tin;

@property(strong,nonatomic) NSMutableArray *brands;


@end
