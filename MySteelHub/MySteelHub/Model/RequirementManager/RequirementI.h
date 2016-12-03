//
//  RequirementI.h
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequirementI : NSObject

@property(strong,nonatomic) NSString *requirementID;
@property(strong,nonatomic) NSString *userID;
@property(assign,nonatomic) BOOL isPhysical;
@property(assign,nonatomic) BOOL isChemical;
@property(assign,nonatomic) BOOL isTestCertificateRequired;
@property(strong,nonatomic) NSString *length;
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *budget;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *requiredByDate;
@property(strong,nonatomic) NSDate *createdDate;
@property(strong,nonatomic) NSDate *modifiedDate;
@property(strong,nonatomic) NSString *taxType;


@property(strong,nonatomic) NSMutableArray *arraySpecifications;
@property(strong,nonatomic) NSString *gradeRequired;
@property(strong,nonatomic) NSMutableArray *arrayPreferedBrands;

@property(strong,nonatomic) NSString *initialAmount;
@property(strong,nonatomic) NSString *bargainAmount;
@property(assign,nonatomic) BOOL isBestPrice;
@property(assign,nonatomic) BOOL isSellerRead;
@property(assign,nonatomic) BOOL isSellerReadBargain;
@property(assign,nonatomic) BOOL isAccepted;
@property(assign,nonatomic) BOOL isDeleted;
@property(assign,nonatomic) BOOL isBargainRequired;


@property(strong,nonatomic) NSMutableArray *arraySpecificationsResponse;


-(void)postQuotation:(void(^)(NSDictionary *json, NSError *error))completionBlock;
-(void)acceptRejectBargain:(void(^)(NSDictionary *json, NSError *error))completionBlock;
-(void)updateSellerReadStatus:(void(^)(NSDictionary *json, NSError *error))completionBlock;
-(void)updateSellerReadBargainStatus:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)selllerDeletedPost:(void(^)(NSDictionary *json, NSError *error))completionBlock;



@end
