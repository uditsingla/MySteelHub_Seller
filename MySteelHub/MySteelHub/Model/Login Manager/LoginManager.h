//
//  TaskManager.h
//  Eventuosity
//
//  Created by Leo Macbook on 13/02/14.
//  Copyright (c) 2014 Eventuosity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"


@interface LoginManager : NSObject
{
    
}

- (void)userLogin:(NSDictionary *)dictParam completion:(void(^)(NSArray *addresses, NSError *error))completionBlock;
-(void)userSignUp:(NSDictionary *)dictParam completion:(void(^)(NSArray *addresses, NSError *error))completionBlock;

-(void)recoverPassword:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)changePassword:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;


-(void)logoutWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;


@end
