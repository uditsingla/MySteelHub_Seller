//
//  RequirementManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementManager.h"

@implementation RequirementManager

@synthesize arrayPostedRequirements,arraySteelBrands,arraySteelSizes,arraySteelGrades,arrayStates,requirementListingDelegate,requirementDetailDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        arrayPostedRequirements = [NSMutableArray new];
        arraySteelBrands = [NSMutableArray new];
        arraySteelSizes = [NSMutableArray new];
        arraySteelGrades = [NSMutableArray new];
        arrayStates = [NSMutableArray new];
    }
    return self;
}

-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:requirement.userID,@"user_id",  requirement.arraySpecifications,@"specification",requirement.gradeRequired,@"grade_required",[NSNumber numberWithBool:requirement.isPhysical],@"physical",[NSNumber numberWithBool: requirement.isChemical],@"chemical",[NSNumber numberWithBool:requirement.isTestCertificateRequired],@"test_certificate_required",requirement.length,@"length",requirement.type,@"type",requirement.arrayPreferedBrands,@"preffered_brands",requirement.requiredByDate,@"required_by_date",requirement.budget,@"budget",requirement.city,@"city",requirement.state,@"state",nil];

    
    [RequestManager asynchronousRequestWithPath:@"buyer/post" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            if([[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"])
            {
                requirement.requirementID = [NSString stringWithFormat:@"%i",[[[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"] intValue]];
                
                [model_manager.requirementManager.arrayPostedRequirements addObject:requirement];
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


-(void)deleteRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:requirement.requirementID,@"requirement_id",@"seller",@"type",nil];
    
    [RequestManager asynchronousRequestWithPath:@"deletePost" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [model_manager.requirementManager.arrayPostedRequirements removeObject:requirement];
            
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

-(void)getPostedRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"user_id",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"posted/requirements" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arrayPostedRequirements removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                RequirementI *requirement = [RequirementI new];
                requirement.userID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"user_id"] intValue]];
                
                requirement.requirementID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"requirement_id"] intValue]];
                
                requirement.isPhysical = [[[array objectAtIndex:i] valueForKey:@"physical"] boolValue];
                
                requirement.isChemical = [[[array objectAtIndex:i] valueForKey:@"chemical"] boolValue];

                requirement.isTestCertificateRequired = [[[array objectAtIndex:i] valueForKey:@"test_certificate_required"] boolValue];

                requirement.length = [[array objectAtIndex:i] valueForKey:@"length"];
                
                requirement.type = [[array objectAtIndex:i] valueForKey:@"type"];

                requirement.budget = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"budget"]];

                requirement.city = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"city"]];

                requirement.state = [[array objectAtIndex:i] valueForKey:@"state"];
                
                requirement.requiredByDate = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"required_by_date"]];

                requirement.arraySpecifications = [[array objectAtIndex:i] valueForKey:@"quantity"];
                
                requirement.gradeRequired = [NSString stringWithFormat:@"%i",[[[array objectAtIndex:i] valueForKey:@"grade_required"] intValue]];

                requirement.arrayPreferedBrands = [[array objectAtIndex:i] valueForKey:@"preffered_brands"];

                [arrayPostedRequirements addObject:requirement];
                

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

-(void)getAllRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"user_id",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"all/requirements" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arrayPostedRequirements removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                RequirementI *requirement = [RequirementI new];
                requirement.userID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"user_id"] intValue]];
                
                requirement.requirementID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"requirement_id"] intValue]];
                
                requirement.isPhysical = [[[array objectAtIndex:i] valueForKey:@"physical"] boolValue];
                
                requirement.isChemical = [[[array objectAtIndex:i] valueForKey:@"chemical"] boolValue];
                
                requirement.isTestCertificateRequired = [[[array objectAtIndex:i] valueForKey:@"test_certificate_required"] boolValue];
                
                requirement.length = [[array objectAtIndex:i] valueForKey:@"length"];
                
                requirement.type = [[array objectAtIndex:i] valueForKey:@"type"];
                
                requirement.budget = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"budget"]];
                
                requirement.city = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"city"]];
                
                requirement.state = [[array objectAtIndex:i] valueForKey:@"state"];
                
                requirement.requiredByDate = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"required_by_date"]];
                
                requirement.taxType = [[array objectAtIndex:i] valueForKey:@"tax_type"];
                
                requirement.isBargainRequired = [[[array objectAtIndex:i] valueForKey:@"req_for_bargain"] boolValue];

                
                requirement.arraySpecifications = [[[array objectAtIndex:i] valueForKey:@"quantity"] mutableCopy];
                
                requirement.arraySpecificationsResponse = [[[array objectAtIndex:i] valueForKey:@"quantity"] mutableCopy];
                
                if(![[[array objectAtIndex:i] valueForKey:@"customer_type"] isEqual:[NSNull null]])
                {
                    requirement.arrayCustomerType = [[[array objectAtIndex:i] valueForKey:@"customer_type"] mutableCopy];
                }


                if([[array objectAtIndex:i] valueForKey:@"initial_unit_price"] && ![[[array objectAtIndex:i] valueForKey:@"initial_unit_price"] isEqual:[NSNull null]])
                {
                    if([[[array objectAtIndex:i] valueForKey:@"initial_unit_price"] isKindOfClass:[NSArray class]])
                    {
                        requirement.arraySpecificationsResponse = [[[array objectAtIndex:i] valueForKey:@"initial_unit_price"] mutableCopy];
                    }
                    else
                    {
                        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:requirement.arraySpecificationsResponse];
                        
                        [requirement.arraySpecificationsResponse removeAllObjects];
                        
                        for(int k=0 ; k<tempArray.count ; k++)
                        {
                            NSMutableDictionary *dict = [[tempArray objectAtIndex:k] mutableCopy];
                            [dict setValue:@"" forKey:@"unit price"];
                            
                            [requirement.arraySpecificationsResponse addObject:dict];
                        }
                    }
                }
                else
                {
                    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:requirement.arraySpecificationsResponse];
                    
                    [requirement.arraySpecificationsResponse removeAllObjects];
                    
                    for(int k=0 ; k<tempArray.count ; k++)
                    {
                        NSMutableDictionary *dict = [[tempArray objectAtIndex:k] mutableCopy];
                        [dict setValue:@"" forKey:@"unit price"];
                        
                        [requirement.arraySpecificationsResponse addObject:dict];
                    }
                }
                
                if([[array objectAtIndex:i] valueForKey:@"bargain_unit_price"] && ![[[array objectAtIndex:i] valueForKey:@"bargain_unit_price"] isEqual:[NSNull null]])
                {
                    if([[[array objectAtIndex:i] valueForKey:@"bargain_unit_price"] isKindOfClass:[NSArray class]])
                    {
                        requirement.arraySpecificationsResponse = [[[array objectAtIndex:i] valueForKey:@"bargain_unit_price"] mutableCopy];
                    }
                    else if(requirement.isBargainRequired)
                    {
                        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:requirement.arraySpecificationsResponse];
                        
                        [requirement.arraySpecificationsResponse removeAllObjects];
                        
                        for(int k=0 ; k<tempArray.count ; k++)
                        {
                            NSMutableDictionary *dict = [[tempArray objectAtIndex:k] mutableCopy];
                            [dict setValue:@"" forKey:@"new unit price"];
                            
                            [requirement.arraySpecificationsResponse addObject:dict];
                        }
                    }
                }
                else if(requirement.isBargainRequired)
                {
                    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:requirement.arraySpecificationsResponse];
                    
                    [requirement.arraySpecificationsResponse removeAllObjects];
                    
                    for(int k=0 ; k<tempArray.count ; k++)
                    {
                        NSMutableDictionary *dict = [[tempArray objectAtIndex:k] mutableCopy];
                        [dict setValue:@"" forKey:@"new unit price"];
                        
                        [requirement.arraySpecificationsResponse addObject:dict];
                    }
                }

                
                requirement.gradeRequired = [NSString stringWithFormat:@"%i",[[[array objectAtIndex:i] valueForKey:@"grade_required"] intValue]];
                
                requirement.arrayPreferedBrands = [[array objectAtIndex:i] valueForKey:@"preffered_brands"];
                
                if([[array objectAtIndex:i] valueForKey:@"brands"] && ![[[array objectAtIndex:i] valueForKey:@"brands"] isEqual:[NSNull null]])
                    requirement.arrayBrands = [[array objectAtIndex:i] valueForKey:@"brands"];

                
                requirement.initialAmount = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"initial_amt"]];
                
                requirement.bargainAmount = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"bargain_amt"]];

                
                requirement.isSellerRead = [[[array objectAtIndex:i] valueForKey:@"is_seller_read"] boolValue];

                requirement.isSellerReadBargain = [[[array objectAtIndex:i] valueForKey:@"is_seller_read_bargain"] boolValue];

                requirement.isBestPrice = [[[array objectAtIndex:i] valueForKey:@"is_best_price"] boolValue];

                requirement.isAccepted = [[[array objectAtIndex:i] valueForKey:@"is_accepted"] boolValue];

                requirement.isDeleted = [[[array objectAtIndex:i] valueForKey:@"is_seller_deleted"] boolValue];

                requirement.isBargainRequired = [[[array objectAtIndex:i] valueForKey:@"req_for_bargain"] boolValue];

                
                [arrayPostedRequirements addObject:requirement];
                
                
            }
            
            if(completionBlock)
                completionBlock(json,nil);
            else
            {
                [requirementDetailDelegate newUpdateReceived];
                [requirementListingDelegate newUpdateReceived];
            }
        }
        else{
            if(completionBlock)
                completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
}

-(void)getSteelBrands:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"brands" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelBrands removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelBrands addObject:[array objectAtIndex:i]];
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

-(void)getSteelSizes:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"steelsizes" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
       // NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelSizes removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelSizes addObject:[array objectAtIndex:i]];
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

-(void)getSteelGrades:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"grades" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelGrades removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelGrades addObject:[array objectAtIndex:i]];
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

-(void)getStates:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"states" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        //NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arrayStates removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arrayStates addObject:[array objectAtIndex:i]];
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

-(void)resetData
{
    [arrayPostedRequirements removeAllObjects];
}

@end
