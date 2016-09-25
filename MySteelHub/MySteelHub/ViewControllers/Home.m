//
//  Home.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Home.h"
#import "HomeCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"

//#import <GoogleMaps/GoogleMaps.h>
#import "RequirementI.h"

@interface Home ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,SWTableViewCellDelegate>
{
    __weak IBOutlet UISwitch *switchPhysical;
    __weak IBOutlet UISwitch *switchChemical;
    __weak IBOutlet UISwitch *switchCertReq;
    
    __weak IBOutlet UISegmentedControl *sgmtControlLenghtRequired;
    
    __weak IBOutlet UISegmentedControl *sgmtControlTypeRequired;
    
    __weak IBOutlet UIButton *btnPreferedBrands;
    
    __weak IBOutlet UIButton *btnGradeRequired;
    
    __weak IBOutlet UITextField *txtFieldCity;
    
    __weak IBOutlet UITextField *txtFieldState;
    
    __weak IBOutlet UITextField *txtFieldBudget;
    
    __weak IBOutlet UIButton *btnRequiredByDate;
    
    __weak IBOutlet UIButton *btnPreferedTax;
    
    __weak IBOutlet UIView *viewQuotation;
    
    __weak IBOutlet UITextField *txtFieldQuotation;
    
    __weak IBOutlet UIView *viewBargain;
    
    __weak IBOutlet UISwitch *switchBargain;
    
    __weak IBOutlet UITextField *txtFieldBargainAmount;
    
    __weak IBOutlet UIButton *btnSubmit;
    
    CLLocationManager *locationManager;
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UITableView *tblViewSizes;
    NSString *selectedDiameter;
    UITextField *selectedDiameterTextfield;
    
    NSMutableArray *arrayTblDict;
    
    UIView *pickerToolBarView;
    NSMutableArray *arraySteelSizes;
    
    UIView *pickerPreferredBrandsView;
    NSMutableArray *arrayPreferredBrands;
    NSMutableArray *arraySelectedPreferredBrands;
    
    
    UIView *pickerGradeRequiredView;
    NSMutableArray *arrayGradeRequired;
    NSString *selectedGradeRequired;
    
    UIView *datePickerView;
    NSString *selectedDate;
    
    UIView *pickerTaxView;
    NSMutableArray *arrayTaxes;
    NSString *selectedTax;
    
    UILabel *lbCity,*lbState,*lbAmount,*lbQuotationAmount,*lbBargainAmount;
    
    //for content view border
    UILabel *lbl;
    
    
    
    __weak IBOutlet UITextField *txtFieldQuantity;
    
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet NSLayoutConstraint *tblViewHeightConstraint;
    __weak IBOutlet NSLayoutConstraint *scrollContentViewHeightConstraint;
}

- (IBAction)preferedBrandsBtnAction:(UIButton *)sender;
- (IBAction)gradeRequiredBtnAction:(UIButton *)sender;
- (IBAction)submitBtnAction:(UIButton *)sender;
- (IBAction)requiredByDateBtnAction:(UIButton *)sender;
- (IBAction)preferedTaxBtnAction:(UIButton *)sender;


@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    model_manager.requirementManager.requirementDetailDelegate = self;

    
    //La
    lbl = [[UILabel alloc]init];
    
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-135);
    //lblBorderColor.backgroundColor = kBlueColor;
    lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lbl.layer.borderWidth = 1.0;
    [contentView addSubview:lbl];
    
    
    //switch controlls reframe
    switchPhysical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchPhysical.onTintColor = kBlueColor
    
    switchChemical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchChemical.onTintColor = kBlueColor
    
    switchCertReq.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchCertReq.onTintColor = kBlueColor
    
    switchBargain.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchBargain.onTintColor = kBlueColor
    
    viewQuotation.hidden = NO;
    viewBargain.hidden = YES;
    
    btnSubmit.hidden = NO;
    
    if(_selectedRequirement.isBargainRequired)
    {
        viewBargain.hidden = NO;
        
        btnSubmit.hidden = NO;
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil ];
    
    if(_selectedRequirement)
    {
        [self setTitleLabel:@"ORDER DETAILS"];
    }
    else
        [self setTitleLabel:@"NEW REQUIREMENT"];
    
    [self setMenuButton];
    [self setBackButton];
    
    
    //Custom UI for TextFilds
    [self customtxtfield:txtFieldCity withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    [self customtxtfield:txtFieldState withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    [self customtxtfield:txtFieldBudget withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    
    //New Implemetation
    UIFont *font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    
    
    
    lbCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 15)];
    lbCity.textColor =  kPlaceHolderGrey;
    lbCity.font = font;
    lbCity.text = @"   Delivery City ";
    [txtFieldCity setLeftView:lbCity];
    [txtFieldCity setLeftViewMode:UITextFieldViewModeAlways];
    
    lbState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 15)];
    lbState.textColor =  kPlaceHolderGrey;
    lbState.font = font;
    lbState.text = @"   State ";
    [txtFieldState setLeftView:lbState];
    [txtFieldState setLeftViewMode:UITextFieldViewModeAlways];
    
    lbAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 15)];
    lbAmount.textColor =  kPlaceHolderGrey;
    lbAmount.font = font;
    lbAmount.text = @"   Budget Amount (Rs) ";
    [txtFieldBudget setLeftView:lbAmount];
    [txtFieldBudget setLeftViewMode:UITextFieldViewModeAlways];
    
    
    
    lbQuotationAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 165, 15)];
    lbQuotationAmount.textColor =  kPlaceHolderGrey;
    lbQuotationAmount.font = font;
    lbQuotationAmount.text = @"Quotation Amount (Rs) ";
    [txtFieldQuotation setLeftView:lbQuotationAmount];
    [txtFieldQuotation setLeftViewMode:UITextFieldViewModeAlways];
    
    lbBargainAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 155, 15)];
    lbBargainAmount.textColor =  kPlaceHolderGrey;
    lbBargainAmount.font = font;
    lbBargainAmount.text = @"Bargain Amount (Rs) ";
    [txtFieldBargainAmount setLeftView:lbBargainAmount];
    [txtFieldBargainAmount setLeftViewMode:UITextFieldViewModeAlways];
    
    /*
    [txtFieldCity setValue:[UIColor lightGrayColor]
                forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldState setValue:[UIColor lightGrayColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldBudget setValue:[UIColor lightGrayColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    [txtFieldQuotation setValue:[UIColor lightGrayColor]
                     forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldBargainAmount setValue:[UIColor lightGrayColor]
                         forKeyPath:@"_placeholderLabel.textColor"];
    */
    
    //    btnGradeRequired.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnPreferedBrands.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnRequiredByDate.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    
    arrayTblDict = [NSMutableArray new];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewSizes.dataSource = self;
    tblViewSizes.delegate = self;
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
    [tblViewSizes reloadData];
    //[self getUserLocation];
    /*
     GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
     longitude:151.2086
     zoom:6];
     //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     GMSMarker *marker = [[GMSMarker alloc] init];
     marker.position = camera.target;
     marker.snippet = @"Hello World";
     marker.appearAnimation = kGMSMarkerAnimationPop;
     marker.map = mapView;
     self.view = mapView;
     */
    
    
    if(model_manager.requirementManager.arraySteelSizes.count>0)
        arraySteelSizes = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelSizes];
    else
        arraySteelSizes = [NSMutableArray new];
    
    // initiaize picker view
    pickerToolBarView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerToolBarView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:111 inView:pickerToolBarView];
    [self.view addSubview:pickerToolBarView];
    pickerToolBarView.hidden = YES;
    
    //arrayPreferredBrands = [NSMutableArray arrayWithObjects:@"Birla",@"Binani",@"Jindal",@"Reliance",@"Tata", nil];
    if(model_manager.requirementManager.arraySteelBrands.count>0)
        arrayPreferredBrands = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelBrands];
    else
        arrayPreferredBrands = [NSMutableArray new];
    
    
    arraySelectedPreferredBrands = [NSMutableArray new];
    
    // initiaize picker view
    pickerPreferredBrandsView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerPreferredBrandsView setBackgroundColor:[UIColor whiteColor]];
    [self createTableViewWithTag:222 inView:pickerPreferredBrandsView];
    [self.view addSubview:pickerPreferredBrandsView];
    pickerPreferredBrandsView.hidden = YES;
    
    //arrayGradeRequired = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D", nil];
    if(model_manager.requirementManager.arraySteelGrades.count>0)
        arrayGradeRequired = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelGrades];
    else
        arrayGradeRequired = [NSMutableArray new];
    
    
    // initiaize picker view
    pickerGradeRequiredView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerGradeRequiredView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:333 inView:pickerGradeRequiredView];
    [self.view addSubview:pickerGradeRequiredView];
    pickerGradeRequiredView.hidden = YES;
    
    //initialize date picker
    datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [datePickerView setBackgroundColor:[UIColor whiteColor]];
    [self createDatePickerWithTag:444 inView:datePickerView];
    [self.view addSubview:datePickerView];
    datePickerView.hidden = YES;
    
    //initialize taxes picker
    pickerTaxView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerTaxView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:555 inView:pickerTaxView];
    [self.view addSubview:pickerTaxView];
    pickerTaxView.hidden = YES;
    
    arrayTaxes = [NSMutableArray arrayWithObjects:@"CST",@"VAT",@"SST", nil];
    
    [model_manager.requirementManager getSteelBrands:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelBrands.count>0)
        {
            arrayPreferredBrands = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelBrands];
            UITableView *tblView = [pickerPreferredBrandsView viewWithTag:222];
            [tblView reloadData];
            
        }
    }];
    
    [model_manager.requirementManager getSteelSizes:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelSizes.count>0)
        {
            arraySteelSizes = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelSizes];
            UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
            [pickerView reloadAllComponents];
        }
    }];
    
    [model_manager.requirementManager getSteelGrades:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelGrades.count>0)
        {
            arrayGradeRequired = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelGrades];
            UIPickerView *pickerView = [pickerGradeRequiredView viewWithTag:333];
            [pickerView reloadAllComponents];
        }
    }];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlackOpaque;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace,doneButton, nil]];
    txtFieldBudget.inputAccessoryView = keyboardDoneButtonView;
    
    txtFieldQuantity.inputAccessoryView = keyboardDoneButtonView;
    
    txtFieldQuotation.inputAccessoryView = keyboardDoneButtonView;
    
    txtFieldBargainAmount.inputAccessoryView = keyboardDoneButtonView;
    
    
    if(_selectedRequirement)
    {
        [self updateRequirementDetails];
    }
}

-(void)updateRequirementDetails
{
    [self disableUIElements];
    arrayTblDict = nil;
    arrayTblDict = _selectedRequirement.arraySpecifications;
    tblViewHeightConstraint.constant = (arrayTblDict.count)*44 + 5;
    scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + tblViewHeightConstraint.constant - 150;
    [tblViewSizes reloadData];
    
    //lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-50);
    
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,tblViewHeightConstraint.constant  + 470 );
    
    if(_selectedRequirement.isBargainRequired)
    {
        lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,tblViewHeightConstraint.constant  + 530 );
    }
    
    
    switchPhysical.on = _selectedRequirement.isPhysical;
    switchChemical.on = _selectedRequirement.isChemical;
    switchCertReq.on = _selectedRequirement.isTestCertificateRequired;
    sgmtControlLenghtRequired.selectedSegmentIndex = [_selectedRequirement.length intValue];
    sgmtControlTypeRequired.selectedSegmentIndex = [_selectedRequirement.type intValue];
    
    [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[_selectedRequirement.arrayPreferedBrands componentsJoinedByString:@","]] forState:UIControlStateNormal];
    
    [btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",_selectedRequirement.gradeRequired] forState:UIControlStateNormal];
    txtFieldCity.text = _selectedRequirement.city;
    txtFieldState.text = _selectedRequirement.state;
    txtFieldBudget.text = _selectedRequirement.budget;
    
    [btnRequiredByDate setTitle:[NSString stringWithFormat:@"Required by Date : %@",_selectedRequirement.requiredByDate] forState:UIControlStateNormal];
    
    [btnPreferedTax setTitle:[NSString stringWithFormat:@"Prefered Tax : %@",_selectedRequirement.taxType] forState:UIControlStateNormal];
    
    
    if(!_selectedRequirement.isSellerRead)
    {
        [_selectedRequirement updateSellerReadStatus:^(NSDictionary *json, NSError *error) {
            
        }];
    }
    else if(!_selectedRequirement.isSellerReadBargain && _selectedRequirement.isBargainRequired)
    {
        [_selectedRequirement updateSellerReadBargainStatus:^(NSDictionary *json, NSError *error) {
            
        }];
    }
    

    if(_selectedRequirement.initialAmount.intValue>0)
    {
        lbQuotationAmount.text = @"Quotation Amount (Rs) :";
        
        txtFieldQuotation.text = [NSString stringWithFormat:@"%@", _selectedRequirement.initialAmount];
        txtFieldQuotation.userInteractionEnabled = NO;
        btnSubmit.hidden = YES;
    }
    
    if(_selectedRequirement.isBargainRequired)
    {
        btnSubmit.hidden = NO;
    }
    
    if(_selectedRequirement.bargainAmount.intValue>0)
    {
        lbBargainAmount.text = @"Bargain Amount (Rs) :";
        txtFieldBargainAmount.text = [NSString stringWithFormat:@"%@", _selectedRequirement.bargainAmount];
        txtFieldBargainAmount.userInteractionEnabled = NO;
        switchBargain.userInteractionEnabled = NO;
        btnSubmit.hidden = YES;
    }
    else if(_selectedRequirement.isBestPrice)
    {
        txtFieldBargainAmount.userInteractionEnabled = NO;
        switchBargain.userInteractionEnabled = NO;
        btnSubmit.hidden = YES;
    }
    
    
    if(_selectedRequirement.isAccepted)
    {
        txtFieldBargainAmount.userInteractionEnabled = NO;
        switchBargain.userInteractionEnabled = NO;
        btnSubmit.hidden = YES;
    }
    
}

-(void)newUpdateReceived
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"requirementID == %@", _selectedRequirement.requirementID];
    NSArray *filteredArray = [model_manager.requirementManager.arrayPostedRequirements filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        _selectedRequirement = [filteredArray firstObject];
        
        [self updateRequirementDetails];
    }
}



- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}


-(void)disableUIElements
{
    tblViewSizes.userInteractionEnabled = NO;
    switchPhysical.userInteractionEnabled = NO;
    switchChemical.userInteractionEnabled = NO;
    switchCertReq.userInteractionEnabled = NO;
    sgmtControlLenghtRequired.userInteractionEnabled = NO;
    sgmtControlTypeRequired.userInteractionEnabled = NO;
    btnPreferedBrands.userInteractionEnabled = NO;
    btnGradeRequired.userInteractionEnabled = NO;
    txtFieldCity.userInteractionEnabled = NO;
    txtFieldState.userInteractionEnabled = NO;
    txtFieldBudget.userInteractionEnabled = NO;
    btnRequiredByDate.userInteractionEnabled = NO;
    pickerToolBarView.userInteractionEnabled = NO;
    pickerPreferredBrandsView.userInteractionEnabled = NO;
    pickerGradeRequiredView.userInteractionEnabled = NO;
    datePickerView.userInteractionEnabled = NO;
    btnPreferedTax.userInteractionEnabled = NO;
}


-(void)createPickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIPickerView *pickerView=[[UIPickerView alloc]init];
    pickerView.frame=CGRectMake(0,0,self.view.frame.size.width, 216);
    pickerView.showsSelectionIndicator = YES;
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.tag = tag;
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:pickerView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)createTableViewWithTag:(int)tag inView:(UIView*)parentview
{
    UITableView *tblView=[[UITableView alloc]init];
    tblView.frame=CGRectMake(0,44,self.view.frame.size.width, 216-44);
    [tblView setDataSource: self];
    [tblView setDelegate: self];
    tblView.tag = tag;
    tblView.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:tblView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tableDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)createDatePickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    [datePicker setFrame:CGRectMake(0,0, self.view.frame.size.width,216)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.timeZone = [NSTimeZone localTimeZone];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.tag = tag;
    
    
    [parentview addSubview:datePicker];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)datePickerDoneButtonPressed
{
    datePickerView.hidden = YES;
    UIDatePicker *datePicker = [datePickerView viewWithTag:444];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    selectedDate = [NSString stringWithFormat:@"%@",
                    [df stringFromDate:datePicker.date]];
    df = nil;
    
    [btnRequiredByDate setTitle:[NSString stringWithFormat:@"Required by Date : %@",selectedDate] forState:UIControlStateNormal];
}


#pragma mark - UIPickerView delgates

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag==111)
        return [arraySteelSizes count];
    else if(pickerView.tag==333)
        return [arrayGradeRequired count];
    else if(pickerView.tag==555)
        return [arrayTaxes count];
    else
        return 0;
    
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag==111)
        return [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]];
    else if(pickerView.tag==333)
        return [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"];
    else if(pickerView.tag==555)
        return [arrayTaxes objectAtIndex: row];
    else
        return @"";
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag==111)
    {
        NSLog(@"You selected this: %@", [[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]);
        selectedDiameter = [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]];
    }
    else if(pickerView.tag==333)
    {
        NSLog(@"You selected this: %@", [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"]);
        selectedGradeRequired = [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"];
    }
    else if(pickerView.tag==555)
    {
        NSLog(@"You selected this: %@", [arrayTaxes objectAtIndex: row]);
        selectedTax = [arrayTaxes objectAtIndex: row];
    }
    
}

-(void)pickerDoneButtonPressed
{
    pickerToolBarView.hidden = YES;
    if(selectedDiameter.length>0)
    {
        selectedDiameterTextfield.text = selectedDiameter;
        
        // getting indexpath from selected button
        CGPoint center= selectedDiameterTextfield.center;
        CGPoint rootViewPoint = [selectedDiameterTextfield.superview convertPoint:center toView:tblViewSizes];
        NSIndexPath *indexPath = [tblViewSizes indexPathForRowAtPoint:rootViewPoint];
        
        HomeCell *cell = [tblViewSizes cellForRowAtIndexPath:indexPath];
        [cell.txtFieldQuantity becomeFirstResponder];
        
        [[arrayTblDict objectAtIndex:indexPath.row] setValue:selectedDiameter forKey:@"size"];
        
        selectedDiameter = @"";
    }
    
    pickerGradeRequiredView.hidden = YES;
    if(selectedGradeRequired.length>0)
    {
        [btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",selectedGradeRequired] forState:UIControlStateNormal];
        //selectedGradeRequired = @"";
    }
    
    pickerTaxView.hidden = YES;
    if(selectedTax.length>0)
    {
        [btnPreferedTax setTitle:[NSString stringWithFormat:@"Prefered Tax : %@",selectedTax] forState:UIControlStateNormal];
        //selectedTax = @"";
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

-(void)tableDoneButtonPressed
{
    pickerGradeRequiredView.hidden = YES;
    pickerPreferredBrandsView.hidden = YES;
    
    
    if(arraySelectedPreferredBrands.count>0)
    {
        
        [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[arraySelectedPreferredBrands componentsJoinedByString:@", "]] forState:UIControlStateNormal];
        
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}


#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==222)
        return arrayPreferredBrands.count;
    return arrayTblDict.count+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==222)
    {
        static NSString *_simpleTableIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
            
        }
        
        cell.textLabel.text = [[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"];
        
        
        if ([arraySelectedPreferredBrands containsObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    else
    {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        if(indexPath.row==arrayTblDict.count)
        {
            cell.btnAdd.hidden = NO;
            cell.txtFieldDiameter.hidden = YES;
            cell.txtFieldQuantity.hidden = YES;
            [cell setRightUtilityButtons:nil WithButtonWidth:0];
            [cell setDelegate:nil];
            
        }
        else
        {
            cell.txtFieldDiameter.hidden = NO;
            cell.txtFieldQuantity.hidden = NO;
            cell.btnAdd.hidden = YES;
            
            NSArray *arrayRightBtns = [self rightButtons];
            [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:70];
            [cell setDelegate:self];
            
            cell.txtFieldDiameter.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"size"];
            cell.txtFieldQuantity.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"quantity"];
            
        }
        
        if(_selectedRequirement)
        {
            cell.btnAdd.hidden = YES;
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==222)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //the below code will allow multiple selection
        if ([arraySelectedPreferredBrands containsObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]])
        {
            [arraySelectedPreferredBrands removeObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]];
        }
        else
        {
            [arraySelectedPreferredBrands addObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]];
        }
        [tableView reloadData];
    }
    
    else
    {
        
    }
}

- (IBAction)btnAddAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44 + 5;
    scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + tblViewHeightConstraint.constant - 150;

    [tblViewSizes reloadData];
    
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-65);
}

#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btn_accept = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_accept setFrame:CGRectMake(0, 0, 40, 50)];
    [btn_accept setBackgroundColor:[UIColor redColor]];
    [btn_accept setTitle:NSLocalizedString(@"Delete",nil) forState:UIControlStateNormal];
    [btn_accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn_accept];
    
    
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
            
        case 0:
        {
            // delete button is pressed
            if(arrayTblDict.count>1)
            {
                NSIndexPath *indexPath;
                indexPath = [tblViewSizes indexPathForCell:cell];
                
                [arrayTblDict removeObjectAtIndex:indexPath.row];
                tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
                [tblViewSizes reloadData]; // tell table to refresh now
            }
            break;
        }
            
        default: break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods
-(void)getUserLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
}
-(IBAction)btnClicked:(id)sender
{
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
    }];
}


//- (IBAction)btnPhysical:(id)sender {
//    if (btnPhysical.selected==NO) {
//        btnPhysical.selected=YES;
//    }
//    else{
//        btnPhysical.selected=NO;
//    }
//}
//
//- (IBAction)btnChemical:(id)sender {
//    if (btnChemical.selected==NO) {
//        btnChemical.selected=YES;
//    }
//    else{
//        btnChemical.selected=NO;
//    }
//    
//}
//- (IBAction)btnCertReq:(id)sender {
//    if (btnCertReq.selected==NO) {
//        btnCertReq.selected=YES;
//    }
//    else{
//        btnCertReq.selected=NO;
//    }
//    
//}


-(void)Back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==786)
    {
        // getting indexpath from selected textfield
        CGPoint center= textField.center;
        CGPoint rootViewPoint = [textField.superview convertPoint:center toView:tblViewSizes];
        NSIndexPath *indexPath = [tblViewSizes indexPathForRowAtPoint:rootViewPoint];
        
        [[arrayTblDict objectAtIndex:indexPath.row] setValue:textField.text forKey:@"quantity"];
    }
    else if (textField == txtFieldCity)
    {
        if(txtFieldCity.text.length == 0)
            lbCity.text = @"   Delivery City ";
        
    }
    else if (textField == txtFieldState)
    {
        if(txtFieldState.text.length == 0)
            lbState.text = @"   State ";
        
    }
    else if (textField == txtFieldBudget)
    {
        if(txtFieldBudget.text.length == 0)
            lbAmount.text = @"   Budget Amount (Rs) ";
        
    }
    
    else if (textField == txtFieldQuotation)
    {
        if(txtFieldQuotation.text.length == 0)
            lbQuotationAmount.text = @"Quotation Amount (Rs) ";
            
    }
    
    else if (textField == txtFieldBargainAmount)
    {
        if(txtFieldBargainAmount.text.length == 0)
            lbBargainAmount.text = @"Bargain Amount (Rs) ";
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag==777)
    {
        pickerToolBarView.hidden = NO;
        [self.view bringSubviewToFront:pickerToolBarView];
        //        if(textField.text.length>0)
        //        {
        //            selectedDiameter = textField.text;
        //        }
        //        else
        
        selectedDiameter = [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: 0] valueForKey:@"size"]];
        
        UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
        
        
        [pickerView selectRow:0 inComponent:0 animated:NO];
        
        
        selectedDiameterTextfield = textField;
        [textField resignFirstResponder];
    }
    
    else if (textField == txtFieldCity)
    {
        lbCity.text = @"   Delivery City :";
        
    }
    else if (textField == txtFieldState)
    {
        lbState.text = @"   State :";
        
    }
    else if (textField == txtFieldBudget)
    {
        lbAmount.text = @"   Budget Amount (Rs) :";
        
    }
    
    else if (textField == txtFieldQuotation)
    {
            lbQuotationAmount.text = @"Quotation Amount (Rs) :";
        
    }
    
    else if (textField == txtFieldBargainAmount)
    {
            lbBargainAmount.text = @"Bargain Amount (Rs) :";
        
    }
}


#pragma mark - Core Location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to get your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    // After fetching the user location stop updating the location.
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
        } break;
        case kCLAuthorizationStatusDenied: {
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

#pragma mark Keyboard
-(void)showKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, kbSize.height, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}
-(void)hideKeyboard:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0,0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

-(void)Closekeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard hidden");
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)preferedBrandsBtnAction:(UIButton *)sender {
    pickerPreferredBrandsView.hidden = NO;
    [self.view bringSubviewToFront:pickerPreferredBrandsView];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

- (IBAction)gradeRequiredBtnAction:(UIButton *)sender {
    pickerGradeRequiredView.hidden = NO;
    [self.view bringSubviewToFront:pickerGradeRequiredView];
    selectedGradeRequired = [[arrayGradeRequired objectAtIndex: 0] valueForKey:@"grade"];
    
    UIPickerView *pickerView = [pickerGradeRequiredView viewWithTag:333];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

- (IBAction)submitBtnAction:(UIButton *)sender {
    
    if(viewBargain.hidden)
    {
        if(txtFieldQuotation.text.length > 0)
        {
            
            [SVProgressHUD show];
            _selectedRequirement.initialAmount = txtFieldQuotation.text;
            [_selectedRequirement postQuotation:^(NSDictionary *json, NSError *error) {
                if(!error)
                {
                    [SVProgressHUD dismiss];
                    btnSubmit.hidden = YES;
                    txtFieldQuotation.userInteractionEnabled = NO;
                    [self showAlert:@"Quotation posted successfully"];
                }
            }];
        }
        else
            [self showAlert:@"Please enter quotation amount"];

    }
    
    else if(switchBargain.isOn)
    {
        if([[txtFieldBargainAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        {
            [self showAlert:@"Please enter bargain amount"];
        }
        
        else
        {
            [SVProgressHUD show];
            
            _selectedRequirement.bargainAmount = txtFieldBargainAmount.text;
            _selectedRequirement.isBestPrice = !switchBargain.isOn;
            [_selectedRequirement acceptRejectBargain:^(NSDictionary *json, NSError *error) {
                [SVProgressHUD dismiss];
                if(json)
                {
                    btnSubmit.hidden = YES;
                    //[self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self showAlert:@"Some error occured. Please try again"];
                }
            }];
        }
    }
    else
    {
        [SVProgressHUD show];
        
        _selectedRequirement.isBestPrice = !switchBargain.isOn;
        [_selectedRequirement acceptRejectBargain:^(NSDictionary *json, NSError *error) {
            [SVProgressHUD dismiss];
            if(json)
            {
                btnSubmit.hidden = YES;
                //[self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlert:@"Some error occured. Please try again"];
            }
        }];

    }
}

- (IBAction)requiredByDateBtnAction:(UIButton *)sender {
    datePickerView.hidden = NO;
    [self.view bringSubviewToFront:datePickerView];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

- (IBAction)preferedTaxBtnAction:(UIButton *)sender {
    pickerTaxView.hidden = NO;
    [self.view bringSubviewToFront:pickerTaxView];
    
    selectedTax = [NSString stringWithFormat:@"%@",[arrayTaxes objectAtIndex: 0]];
    
    UIPickerView *pickerView = [pickerTaxView viewWithTag:555];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
}

-(void)showAlert:(NSString *)errorMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:errorMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             //   [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
}


@end
