//
//  LeftSlider.m
//  ApiTap
//
//  Created by Abhishek Singla on 16/03/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "LeftSlider.h"
#import "LeftSliderCell.h"
#import "SignUP.h"

//#import "Appointments.h"
//#import "History.h"

#define klblMenuItem 10
#define kimgMenuItem 2


@interface LeftSlider ()
{
    NSArray *arrMenuItems, *arrMenuItemsImages;
}
@end

@implementation LeftSlider

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrMenuItems = [NSArray arrayWithObjects:@"Home",
                    @"History",
                    @"Change Password",
                    @"Contact Us",
                    [NSString stringWithFormat:@"Logout"],nil];
    
    arrMenuItemsImages = [NSArray arrayWithObjects:@"home.png",
                          @"history.png",
                          @"password.png",
                          @"contact.png",
                          @"logout.png",
                          nil];
    
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.tableFooterView = [UIView new];

    
    [model_manager.profileManager getUserProfile:^(NSDictionary *json, NSError *error) {
        if(json)
        {
            [self.tableView reloadData];
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return [arrMenuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *_simpleTableIdentifier = @"CellIdentifier";
    
    //LeftSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier forIndexPath:indexPath];
    
    LeftSliderCell *cell = (LeftSliderCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
    
    
    // Configure the cell...
    if(cell==nil)
    {
        cell = [[LeftSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
        
        
    }
    
    //Menu lable
    //    cell.lblMenuItem.backgroundColor = GreenColor;
    cell.lblMenuItem.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    cell.lblMenuItem.text = [arrMenuItems objectAtIndex:indexPath.row] ;
    cell.lblMenuItem.font = [UIFont fontWithName:@"Raleway-bold" size:14];
    
    //Menu Image
    //UIImageView *imgMenuItem = (UIImageView*)[cell.contentView viewWithTag:kimgMenuItem];
    
    //NSString *imgBundlePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[]];
    cell.imgMenuItem.image = [UIImage imageNamed:[arrMenuItemsImages objectAtIndex:indexPath.row]];
    cell.imgMenuItem.contentMode = UIViewContentModeScaleAspectFit;

    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    /* Section header is in 0th index... */
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"SELLER"];
    
    
    UILabel *labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, tableView.frame.size.width, 18)];
    [labelEmail setFont:[UIFont systemFontOfSize:12]];
    [labelEmail setText:model_manager.profileManager.owner.email];
    NSLog(@"%@",labelEmail.text);
    [labelEmail setTextColor:[UIColor whiteColor]];
    
    [view addSubview:label];
    [view addSubview:labelEmail];
    [view setBackgroundColor:kBlueColor]; //your background color...
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; // Declare the Gesture.
    gesRecognizer.delegate = self;
    [view addGestureRecognizer:gesRecognizer]; // Add Gesture to your view.
    
    return view;
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"Tapped");
    SignUP *signUpVc = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"signUp"];
    signUpVc.isEditProfile = true;
    [self.navigationController pushViewController:signUpVc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


#pragma mark - TableView delegate

-(UIViewController *)goToController:(NSString*)identifier
{
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    
    NSMutableArray *controllers =[navigationController.viewControllers mutableCopy];
    while (controllers.count>1)
    {
        [controllers removeLastObject];
    }
    navigationController.viewControllers = controllers;
    
    
    UIViewController *viewcontroller = [mainstoryboard instantiateViewControllerWithIdentifier: identifier];
    return viewcontroller;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *keyName = arrMenuItems[indexPath.row];
    
    //NSLog(@"Left Menu key : %@",keyName);
    
    if([keyName caseInsensitiveCompare:@"Home"] == NSOrderedSame){
        NSLog(@"Home");
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        
        NSMutableArray *controllers =[navigationController.viewControllers mutableCopy];
        while (controllers.count>1)
        {
            [controllers removeLastObject];
        }
        navigationController.viewControllers = controllers;
        
    }
    
    else if ([keyName caseInsensitiveCompare:@"Change Password"] == NSOrderedSame){
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        
        UIViewController *viewcontroller = [kLoginStoryboard instantiateViewControllerWithIdentifier: @"changepassword"];
        
        [navigationController pushViewController:viewcontroller animated:NO];
    }
    
    
    else if ([keyName caseInsensitiveCompare:@"History"] == NSOrderedSame){
        NSLog(@"History");
        
        
    }
    
    else if ([keyName caseInsensitiveCompare:[NSString stringWithFormat:@"Logout"]] == NSOrderedSame)
    {
        NSLog(@"Logout");
        [SVProgressHUD show];
        
        [model_manager.loginManager logoutWithCompletion:^(NSDictionary *json, NSError *error) {
            [SVProgressHUD dismiss];
            if(json)
            {
                UINavigationController *navController = (UINavigationController*)appdelegate.window.rootViewController;
                [navController popToRootViewControllerAnimated:YES];
            }
        }];
        
    }
    else {
        NSLog(@"else clicked");
        
    }
    
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
    
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
