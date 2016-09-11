//
//  RequirementManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequirementI.h"

@interface RequirementManager : NSObject

@property(strong,nonatomic) NSMutableArray *arrayPostedRequirements;
@property(strong,nonatomic) NSMutableArray *arraySteelBrands;
@property(strong,nonatomic) NSMutableArray *arraySteelSizes;
@property(strong,nonatomic) NSMutableArray *arraySteelGrades;



-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getPostedRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getAllRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelBrands:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelSizes:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelGrades:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)resetData;


@end
