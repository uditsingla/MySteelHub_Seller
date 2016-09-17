//
//  RequirementI.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementI.h"

@implementation RequirementI

@synthesize requirementID,userID,isChemical,isPhysical,isTestCertificateRequired,length,type,budget,city,state,requiredByDate,gradeRequired,arrayPreferedBrands,arraySpecifications,createdDate,modifiedDate,initialAmount,bargainAmount,isBestPrice,isSellerRead,isSellerReadBargain,isAccepted,isDeleted,isBargainRequired,taxType;

- (id)init
{
    self = [super init];
    if (self) {
        requirementID=@"";
        userID=@"";
        length=@"";
        type=@"";
        budget=@"";
        city=@"";
        state=@"";
        requiredByDate = @"";
        arraySpecifications = [NSMutableArray new];
        arrayPreferedBrands = [NSMutableArray new];
        gradeRequired = @"";
        initialAmount = @"";
        bargainAmount = @"";
        isBestPrice = NO;
        isSellerRead = NO;
        isSellerReadBargain = NO;
        isAccepted = NO;
        isDeleted = NO;
        isBargainRequired = NO;
        taxType = @"";
    }
    return self;
}

-(void)postQuotation:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"seller_id", self.userID,@"buyer_id", self.initialAmount,@"initial_amt", @"sellerQuotation",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)acceptRejectBargain:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"seller_id", self.userID,@"buyer_id", self.bargainAmount,@"bargain_amt",[NSNumber numberWithBool:isBestPrice],@"is_best_price", @"sellerAcceptOrNot",@"type",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)updateSellerReadStatus:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"seller_id", self.userID,@"buyer_id", @"sellerReadStatus",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            self.isSellerRead = true;
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

-(void)updateSellerReadBargainStatus:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"seller_id", self.userID,@"buyer_id",@"sellerReadBargain",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)selllerDeletedPost:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"seller_id", self.userID,@"buyer_id",[NSNumber numberWithInt:1],@"is_seller_deleted", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"deletePost" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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
