//
//  Constants.h
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "SVProgressHUD.h"

#define kMainStoryboard [UIStoryboard storyboardWithName:@"Main" bundle: nil]
#define kLoginStoryboard [UIStoryboard storyboardWithName:@"Login" bundle: nil]

//#define kBaseUrlPath @"https://nodejs.org/api/fs.html"
#define kBaseUrlPath @"http://mysteelhub.com/"

#define kBaseUrl [NSURL URLWithString:kBaseUrlPath]

#define kPlaceHolderGrey [UIColor colorWithRed:170/255.00 green:170/255.00 blue:170/255.00 alpha:1];


#define kBlueColor  [UIColor colorWithRed:34/255.00 green:152/255.00 blue:168/255.00 alpha:1]

#define LightGreyColor  [UIColor colorWithRed:234/255.00 green:234/255.00 blue:234/255.00 alpha:1];

#define DarkGreyColor  [UIColor colorWithRed:0/255.00 green:0/255.00 blue:0/255.00 alpha:1];

#define RedColor  [UIColor colorWithRed:212/255.00 green:11/255.00 blue:01/255.00 alpha:1];

#define GreenColor  [UIColor colorWithRed:58/255.00 green:137/255.00 blue:1/255.00 alpha:1];

#define OrangeColor  [UIColor colorWithRed:248/255.00 green:123/255.00 blue:1/255.00 alpha:1];

#define BlackBackground  [UIColor colorWithRed:39/255.00 green:39/255.00 blue:39/255.00 alpha:1];

#define PurpleColor  [UIColor colorWithRed:128/255.00 green:0/255.00 blue:128/255.00 alpha:1];

#define Other  [UIColor colorWithRed:34/255.00 green:36/255.00 blue:85/255.00 alpha:1];

#define kSkyBlueColor  [UIColor colorWithRed:39/255.00 green:170/255.00 blue:186/255.00 alpha:1];

#define fontRaleway12 [UIFont fontWithName:@"Raleway-Regular" size:12]
#define fontRaleway13 [UIFont fontWithName:@"Raleway-Regular" size:13]
#define fontRaleway14 ((UIFont *)[UIFont fontWithName:@"Raleway-Regular" size:14])
#define fontRaleway16 ((UIFont *)[UIFont fontWithName:@"Raleway-Regular" size:16])


#define fontRalewayBold12 [UIFont fontWithName:@"Raleway-SemiBold" size:12]
#define fontRalewayBold13 [UIFont fontWithName:@"Raleway-SemiBold" size:13]
#define fontRalewayBold14 ((UIFont *)[UIFont fontWithName:@"Raleway-SemiBold" size:14])
#define fontRalewayBold16 ((UIFont *)[UIFont fontWithName:@"Raleway-SemiBold" size:16])

#define kBargainReplied @"Bargain Replied"
#define kBargainDemanded @"Bargain Required"
#define kOrderAccepted @"Order Inprogress"
#define kQuoteRequired @"Quote Required"
#define kNewMessage @"New Message"
#define kBargainPending @"Bargain Pending"
#define kBargainDone @"Bargain Done"
#define kQuotePosted @"Quote Posted"




#endif /* Constants_h */
