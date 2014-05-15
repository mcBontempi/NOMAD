#import "OrderDetailsViewController.h"
#import "OrderDetailsTextTableViewCell.h"
#import "OrderDetailsDeliveryTableViewCell.h"
#import "OrderDetailsDeliveryPickerTableViewCell.h"
#import "OrderDetailsTextTableViewCellDelegate.h"

@interface OrderDetailsViewController () <OrderDetailsTextTableViewCellDelegate>

@property (nonatomic, assign) BOOL showPicker;

@end


@implementation OrderDetailsViewController {
    __weak IBOutlet NSLayoutConstraint *_buttonToBottomConstraint;
    __weak IBOutlet UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _buttonToBottomConstraint.constant = -100;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    self.deliverySlot = @"Choose Delivery Slot";
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
            return 1;
        case 2:
            return 1 + (self.showPicker ? 1 : 0);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

/*
 - (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
 [headerView setBackgroundColor:[UIColor whiteColor]];
 return headerView;
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger retVal = 50;
    
    switch (indexPath.section) {
        case 2:
        {
            switch (indexPath.row) {
                case 1:
                {
                    retVal = self.showPicker ? 162 : 0;
                }
            }
            
        }
    }
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
                    [cell configureWithImagePath:@"UserIcon" placeholderText:@"Full Name" lastRow:NO delegate:self];
                    return cell;
                case 1:
                    [cell configureWithImagePath:@"EmailIcon" placeholderText:@"Email Address" lastRow:YES delegate:self];
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
                    [cell configureWithImagePath:@"HomeIcon" placeholderText:@"House Name or No." lastRow:YES delegate:self];
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
                    OrderDetailsTextTableViewCell *cell;
                    
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    [cell resignResponder];
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    [cell resignResponder];
                    cell = (OrderDetailsTextTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                    [cell resignResponder];
                    
                    self.showPicker = !self.showPicker;
                }
            }
            
        }
    }
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
    return self.deliverySlots.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.deliverySlots[row];
}

#pragma mark - PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.deliverySlot = self.deliverySlots[row];
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
    _showPicker = showPicker;
    
    [_tableView beginUpdates];
    
    if (self.showPicker) {
        
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    else {
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    
    [_tableView endUpdates];
}

#pragma mark - OrderDetailsTextTableViewCellDelegate

- (void)returnKeyPressed:(OrderDetailsTextTableViewCell *)sender
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
                    [sender resignResponder];
                    if(!self.showPicker)
                        self.showPicker = YES;
                    
                    break;
                }
            }
            break;
        }
            
    }
    
    
}


@end
