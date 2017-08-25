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

-(void)getUserProfile:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"getProfile" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            if([json valueForKey:@"data"])
            {
                
                if([[json valueForKey:@"data"] valueForKey:@"brand"] && ![[[json valueForKey:@"data"] valueForKey:@"brand"] isEqual:[NSNull null]])
                    owner.brands = [[json valueForKey:@"data"] valueForKey:@"brand"];
                
                NSDictionary *dictData = [json valueForKey:@"data"];
                
                owner.email = [dictData valueForKey:@"email"];
                owner.name = [dictData valueForKey:@"name"];
                owner.address = [dictData valueForKey:@"address"];
                if([dictData valueForKey:@"brand"] && ![[dictData valueForKey:@"brand"] isEqual:[NSNull null]])
                    owner.brands = [dictData valueForKey:@"brand"];
                owner.city = [dictData valueForKey:@"city"];
                owner.companyName = [dictData valueForKey:@"company_name"];
                owner.contactNo = [NSString stringWithFormat:@"%.0f", [[dictData valueForKey:@"contact"] doubleValue]];
                if([dictData valueForKey:@"customer_type"] != nil && [dictData valueForKey:@"customer_type"] != [NSNull null])
                    owner.customerType = [[dictData valueForKey:@"customer_type"] mutableCopy];
                owner.expectedQuantity = [NSString stringWithFormat:@"%.0f",[[dictData valueForKey:@"exp_quantity"] doubleValue]];
                owner.userID = [NSString stringWithFormat:@"%i",[[dictData valueForKey:@"id"] intValue]];
                owner.latitude = [[dictData valueForKey:@"latitude"] doubleValue];
                owner.longitude = [[dictData valueForKey:@"longitude"] doubleValue];
                owner.pan = [NSString stringWithFormat:@"%@",[dictData valueForKey:@"pan"]];
                owner.role = [dictData valueForKey:@"role"];
                owner.state = [dictData valueForKey:@"state"];
                owner.tin = [NSString stringWithFormat:@"%@",[dictData valueForKey:@"tin"]];
                owner.zip = [NSString stringWithFormat:@"%.0f",[[dictData valueForKey:@"zip"] doubleValue]];
            }
            
            if(completionBlock)
                completionBlock(json,nil);
            
        }
        else{
            if(completionBlock)
                completionBlock(nil,nil);
            //show error
        }
        
    } ];
}

- (void)updateProfile:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *response, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"update/profile" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            completionBlock(json,nil);
            
        }
        else{
            completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
    
}

@end
