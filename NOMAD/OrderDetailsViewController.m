#import "OrderDetailsViewController.h"
#import "OrderDetailsTextTableViewCell.h"
#import "OrderDetailsDeliveryTableViewCell.h"
#import "OrderDetailsDeliveryPickerTableViewCell.h"
#import "OrderDetailsTextTableViewCellDelegate.h"
#import "OrderDetailsPostcodeTableViewCell.h"
#import "OrderDetailsPostcodeTableViewCellDelegate.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface OrderDetailsViewController () <OrderDetailsTextTableViewCellDelegate, OrderDetailsPostcodeTableViewCellDelegate>

@property (nonatomic, assign) BOOL showPicker;
@property (nonatomic, assign) BOOL showAddressPicker;

@property (nonatomic, strong) NSArray *shortlistedAddresses;

@end


@implementation OrderDetailsViewController {
    __weak IBOutlet NSLayoutConstraint *_buttonToBottomConstraint;
    
    __weak IBOutlet NSLayoutConstraint *_tableViewToBottomConstraint;
    
    __weak IBOutlet UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _buttonToBottomConstraint.constant = -65;
    _tableViewToBottomConstraint.constant = 0;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    self.deliverySlot = @"Choose Delivery Slot";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize size = [[userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _tableViewToBottomConstraint.constant = size.height;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    _tableViewToBottomConstraint.constant = _buttonToBottomConstraint.constant + 65;
}

- (IBAction)cartButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
            case 0:
            return 2;
            case 1:
            return 3;
            case 2:
            return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger retVal = 50;
    
    switch (indexPath.section) {
            
            case 1:
        {
            switch (indexPath.row)
            {
                    case 2:
                {
                    retVal = self.showAddressPicker ? 162 : 0;
                    break;
                }
            }
            break;
        }
            case 2:
        {
            switch (indexPath.row)
            {
                    case 1:
                {
                    retVal = self.showPicker ? 162 : 0;
                    break;
                }
            }
            break;
        }
    }
    
    NSLog(@"%@, %d",  indexPath.description, retVal);
    
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            case 0:
        {
            OrderDetailsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSTEXTCELLIDENTIFIER" forIndexPath:indexPath];
            
            switch (indexPath.row) {
                    case 0:
                    [cell configureWithImagePath:@"UserIcon" placeholderText:@"Full Name" lastRow:NO delegate:self keyboardType:UIKeyboardTypeDefault autoCapitalisationType:UITextAutocapitalizationTypeWords];
                    return cell;
                    case 1:
                    [cell configureWithImagePath:@"EmailIcon" placeholderText:@"Email Address" lastRow:YES delegate:self keyboardType:UIKeyboardTypeEmailAddress autoCapitalisationType:UITextAutocapitalizationTypeNone];
                    return cell;
            }
            break;
        }
            case 1:
        {
            switch (indexPath.row) {
                    case 0:
                {
                    OrderDetailsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSTEXTCELLIDENTIFIER" forIndexPath:indexPath];
                    [cell configureWithImagePath:@"HomeIcon" placeholderText:@"House Name or No." lastRow:YES delegate:self keyboardType:UIKeyboardTypeDefault autoCapitalisationType:UITextAutocapitalizationTypeWords];
                    return cell;
                }
                    case 1:
                {
                    OrderDetailsPostcodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSPOSTCODECELLIDENTIFIER" forIndexPath:indexPath];
                    [cell configureWithlastRow:YES delegate:self];
                    return cell;
                }
                    case 2:
                {
                    OrderDetailsDeliveryPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSDELIVERYPICKERCELLIDENTIFIER" forIndexPath:indexPath];
                    
                    [cell configureWithDeliveryPickerDelegate:self];
                    return cell;
                }
            }
            break;
        }
            case 2:
        {
            switch (indexPath.row) {
                    case 0:
                {
                    OrderDetailsDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSDELIVERYCELLIDENTIFIER" forIndexPath:indexPath];
                    [cell configureWithDeliverySlotText:self.deliverySlot];
                    return cell;
                }
                    case 1:
                {
                    OrderDetailsDeliveryPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSDELIVERYPICKERCELLIDENTIFIER" forIndexPath:indexPath];
                    
                    [cell configureWithDeliveryPickerDelegate:self];
                    return cell;
                }
            }
            break;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            case 2:
        {
            switch (indexPath.row) {
                    case 0:
                {
                    [self hideKeyboardForAllCellsWithFields];
                    
                    self.showPicker = !self.showPicker;
                }
            }
        }
    }
}

- (void)hideKeyboardForAllCellsWithFields
{
    
    OrderDetailsTextTableViewCell *cell;
    
    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell resignResponder];
    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell resignResponder];
    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell resignResponder];
    
    OrderDetailsPostcodeTableViewCell *postcodeCell;
    postcodeCell = (OrderDetailsPostcodeTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    [postcodeCell resignResponder];
    
}

#pragma mark - PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (self.showPicker)return self.deliverySlots.count;
    
    return _shortlistedAddresses.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (self.showPicker)return self.deliverySlots[row];
    
    return _shortlistedAddresses[row][0];
}

#pragma mark - PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (self.showPicker) self.deliverySlot = self.deliverySlots[row];
    
    //  return _shortlistedAddresses[row][0];
}

#pragma mark - general stuff

- (void)showGetQuoteButton
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         _buttonToBottomConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                         
                     }];
}


- (NSArray *)deliverySlots
{
    return @[@"Choose Delivery Slot",@"6 - 7PM", @"7 - 8PM", @"8 - 9PM",@"9 - 10PM", @"10 - 11PM", @"11 - 12PM"];
}

- (void)setDeliverySlot:(NSString *)deliverySlot
{
    _deliverySlot = deliverySlot;
    
    [_tableView beginUpdates];
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    
    [_tableView endUpdates];
}

- (void)setShowPicker:(BOOL)showPicker
{
    if (self.showAddressPicker) {
        self.showAddressPicker = NO;
    }
    
    _showPicker = showPicker;
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    
    if (_showPicker) {
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    [_tableView beginUpdates];
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:self.showPicker ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
    
    [_tableView endUpdates];
    
    
}

- (void)setShowAddressPicker:(BOOL)showAddressPicker
{
    if (self.showPicker) {
        self.showPicker = NO;
    }
    
    _showAddressPicker = showAddressPicker;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    
    if (_showAddressPicker) {
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    [_tableView beginUpdates];
    
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:self.showAddressPicker ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
    
    [_tableView endUpdates];
    
}

#pragma mark - OrderDetailsTextTableViewCellDelegate

- (void)returnKeyPressedFromOrderDetailsTextTableViewCell:(OrderDetailsTextTableViewCell *)sender
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
    
    OrderDetailsTextTableViewCell *cell;
    
    switch (indexPath.section) {
            case 0:
        {
            switch (indexPath.row) {
                    case 0:
                {
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    [cell becomeResponder];
                    break;
                }
                    case 1:
                {
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                    [cell becomeResponder];
                    break;
                }
            }
            break;
            
        }
            case 1:
        {
            switch (indexPath.row) {
                    case 0:
                {
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                    [cell becomeResponder];
                    
                    
                    /*[sender resignResponder];
                     if(!self.showPicker)
                     self.showPicker = YES;
                     */
                    break;
                }
            }
            break;
        }
    }
}

- (void)beganEditingOrderDetailsTextTableViewCell:(OrderDetailsTextTableViewCell *)sender
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
    
    [_tableView scrollToRowAtIndexPath:indexPath
                      atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
}

- (void)beganEditingOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
    
    [_tableView scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)findTappedOnOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender
{
    if (sender.fieldText.length && self.showAddressPicker == NO) {
        [self hideKeyboardForAllCellsWithFields];
        
        [self doFindForPostcode:sender.fieldText];
    }
    else if(self.showAddressPicker == YES) {
        self.showAddressPicker = NO;
    }
}

- (void)searchForPostcode:(NSString *)postcode
{
    NSString *baseURLString = @"https://api.ideal-postcodes.co.uk:443";
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSDictionary *parameters = @{@"api_key": @"ak_hvhc4kd1FPe2RMqfDybAnJwfnKM5j"};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    [manager GET:@"/v1/postcodes/ID11QD/" parameters:parameters success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        
        
        _shortlistedAddresses = [self parsePostcodeDictionary:dict];
        
        OrderDetailsDeliveryPickerTableViewCell *cell = (OrderDetailsDeliveryPickerTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        [cell reloadPicker];
        
        /*
         NSError *error = nil;
         
         NSObject *object =[NSJSONSerialization JSONObjectWithData:[responseObject dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:&error];
         
         */
        
        NSLog(@"%@", dict);
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Postcode"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}


- (NSArray *)parsePostcodeDictionary:(NSDictionary *)dict
{
    if (dict[@"result"]) {
        
        NSArray *results = dict[@"result"];
        
        
        NSMutableArray *shortlist = [@[] mutableCopy];
        
        [results enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
            
            NSString *line1 = dict[@"line_1"];
            
            [shortlist addObject:@[line1]];
            
        }];
        
        
        return [shortlist copy];
    }
    
    return @[];
}

- (void)doFindForPostcode:(NSString *)postcode
{
    [self searchForPostcode:postcode];
    if(!self.showAddressPicker)
    self.showAddressPicker = YES;

}

- (void)returnKeyPressedFromOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender
{
    [sender resignResponder];

    [self doFindForPostcode:sender.fieldText];
}


@end
