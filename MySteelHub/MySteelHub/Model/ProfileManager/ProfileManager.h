//
//  ProfileManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserI.h"

@interface ProfileManager : NSObject

@property(strong,nonatomic) UserI *owner;

-(void)getUserProfile:(void(^)(NSDictionary *json, NSError *error))completionBlock;
- (void)updateProfile:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *response, NSError *error))completionBlock;

@end
