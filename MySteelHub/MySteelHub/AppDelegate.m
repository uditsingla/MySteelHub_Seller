//
//  AppDelegate.m
//  MySteelHub
//
//  Created by Abhishek Singla on 09/03/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "AppDelegate.h"
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()
{
    
    BOOL autologin;
}

@end

@implementation AppDelegate

@synthesize container ,currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    ///Font name
    
    for (NSString *fontFamilyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            NSLog(@"Family: %@    Font: %@", fontFamilyName, fontName);
        }
    }
    //
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeNone | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert)];
        }
        
    }

    //Location Manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    
    return YES;
}

- (void)initializeInAppNotificationView
{
    //create inAppNotificationView
    inAppNotificationView=[[UIView alloc] init];
    inAppNotificationView.backgroundColor = [UIColor blackColor];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0,0,self.window.frame.size.width,60);
    messageBtn.tag = 1;
    [messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont fontWithName:@"Raleway-regular" size:12];
    messageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    messageBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [messageBtn addTarget:self action:@selector(notificationTappedAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [inAppNotificationView addSubview:messageBtn];
    
    
    [inAppNotificationView sizeToFit];
    inAppNotificationView.frame=CGRectMake(0,-60,self.window.frame.size.width,60);
    [self.window addSubview:inAppNotificationView];
    
    //bring subview to front
    [self.window bringSubviewToFront:inAppNotificationView];
    
    isAlertAnimating=false;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [model_manager.requirementManager getAllRequirements:nil];
    
    [model_manager.requirementManager getSteelBrands:nil];
    
    [model_manager.profileManager getUserProfile:nil];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Location services
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateToLocation: %@", [locations lastObject]);
    currentLocation = [locations lastObject];
    
    NSLog(@"latitudeee : %f",currentLocation.coordinate.latitude);
    NSLog(@"longitudeeee : %f",currentLocation.coordinate.longitude);
    
    if (currentLocation != nil)
    {
        currentLocation = [locations objectAtIndex:0];
        [_locationManager stopUpdatingLocation];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (!(error))
             {
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 NSLog(@"\nCurrent Location Detected\n");
                 NSLog(@"placemark %@",placemark);
                 NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 NSString *Address = [[NSString alloc]initWithString:locatedAt];
                 NSString *Area = [[NSString alloc]initWithString:placemark.locality];
                 NSString *Country = [[NSString alloc]initWithString:placemark.country];
                 NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
                 NSLog(@"%@",CountryArea);
             }
             else
             {
                 NSLog(@"Geocode failed with error %@", error);
                 NSLog(@"\nCurrent Location Not Detected\n");
                 //return;
             }
             //        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"isFirstTime"];
             //        model_manager.profileManager.currentLatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
             //        model_manager.profileManager.currentLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
         }];
    }
    
    // Stop Location Manager
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error while getting core location : %@",[error localizedFailureReason]);
    if ([error code] == kCLErrorDenied) {
        //you had denied
    }
    [manager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch([CLLocationManager authorizationStatus])
    {
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"Location services authorised by user");
            break;
            
        case kCLAuthorizationStatusDenied:
            NSLog(@"Location services denied by user");
            break;
            
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Parental controls restrict location services");
            break;
            
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Unable to determine, possibly not available");
            break;
    }
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "MySteelHub.MySteelHub" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MySteelHub" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MySteelHub.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Push Notification

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    [self handlePushNotification:notification.request.content.userInfo];
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token---%@",token);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"DeviceToken"];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register with error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"received notification%@",userInfo.description);
    
    [self handlePushNotification:userInfo];
    
}

-(void)handlePushNotification:(NSDictionary *)userInfo
{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    
    if(state == UIApplicationStateActive)
    {
        if(inAppNotificationView)
            [self showNotificationView:[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] valueForKey:@"body"]];
        
    }
    else if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        if(container)
        {
            UINavigationController *navigationController = container.centerViewController;
            
            NSMutableArray *controllers =[navigationController.viewControllers mutableCopy];
            while (controllers.count>1)
            {
                [controllers removeLastObject];
            }
            navigationController.viewControllers = controllers;
            
            //[container toggleRightSideMenuCompletion:^{}];
        }
    }

    [model_manager.requirementManager getAllRequirements:nil];

}

#pragma mark - InApp Notification show/hide
-(void)showNotificationView:(NSString *)message
{
    if(isAlertAnimating==true)
        return;
    
    isAlertAnimating=true;
    //    UILabel *lbl_message=(UILabel*)[inAppNotificationView viewWithTag:1];
    //    lbl_message.text=message;
    
    UIButton *btn_message=(UIButton*)[inAppNotificationView viewWithTag:1];
    [btn_message setTitle:message forState:UIControlStateNormal];
    
    //bring subview to front
    [self.window bringSubviewToFront:inAppNotificationView];
    [UIView animateWithDuration:0.3 animations:^{
        inAppNotificationView.frame=CGRectMake(0,0,self.window.frame.size.width,60);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideNotificationView) withObject:Nil afterDelay:5.0f];
    }];
    
    
}
-(void)hideNotificationView
{
    [UIView animateWithDuration:0.3 animations:^{
        inAppNotificationView.frame=CGRectMake(0,-60,self.window.frame.size.width,60);
    } completion:^(BOOL finished) {
        isAlertAnimating=false;
        //[inAppNotificationSound stop];
    }];
}

-(void)notificationTappedAction:(UIButton*)sender
{
    //redirect
    if(container)
    {
        UINavigationController *navigationController = container.centerViewController;
        
        NSMutableArray *controllers =[navigationController.viewControllers mutableCopy];
        while (controllers.count>1)
        {
            [controllers removeLastObject];
        }
        navigationController.viewControllers = controllers;
        
        //[container toggleRightSideMenuCompletion:^{}];
    }
    [self hideNotificationView];
}


@end
