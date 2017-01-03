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
            
            if([[json valueForKey:@"data"] valueForKey:@"brand"] && ![[[json valueForKey:@"data"] valueForKey:@"brand"] isEqual:[NSNull null]])
                owner.brands = [[json valueForKey:@"data"] valueForKey:@"brand"];
                        
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

@end
