//
//  RequirementManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequirementI.h"

//protocol to notify listing view controller
@protocol RequirementListingDelegate <NSObject>

-(void)newUpdateReceived;

@end

//protocol to notify detail view controller
@protocol RequirementDetailDelegate <NSObject>

-(void)newUpdateReceived;

@end


@interface RequirementManager : NSObject

@property(strong,nonatomic) NSMutableArray *arrayPostedRequirements;
@property(strong,nonatomic) NSMutableArray *arraySteelBrands;
@property(strong,nonatomic) NSMutableArray *arraySteelSizes;
@property(strong,nonatomic) NSMutableArray *arraySteelGrades;
@property(strong,nonatomic) NSMutableArray *arrayStates;

@property(weak,nonatomic) id<RequirementListingDelegate> requirementListingDelegate;

@property(weak,nonatomic) id<RequirementDetailDelegate> requirementDetailDelegate;



-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getPostedRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getAllRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelBrands:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelSizes:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getSteelGrades:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getStates:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)deleteRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;


-(void)resetData;


@end
