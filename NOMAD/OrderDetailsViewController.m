#import "OrderDetailsViewController.h"
#import "OrderDetailsTextTableViewCell.h"
#import "OrderDetailsDeliveryTableViewCell.h"

@interface OrderDetailsViewController ()

@property (nonatomic, assign) BOOL showPicker;

@end


@implementation OrderDetailsViewController {
    __weak IBOutlet NSLayoutConstraint *_buttonToBottomConstraint;
    __weak IBOutlet UIPickerView *_deliveryPicker;
    
  
    __weak IBOutlet UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _buttonToBottomConstraint.constant = -100;
    
    _deliveryPicker.delegate = self;
    
    [_deliveryPicker setBackgroundColor:[UIColor whiteColor]];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
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
    switch (indexPath.section) {
        case 2:
        {
            switch (indexPath.row) {
                case 1:
                {
                    return 162;
                }
            }
            
        }
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            OrderDetailsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSTEXTCELLIDENTIFIER" forIndexPath:indexPath];
            
            switch (indexPath.row) {
                case 0:
                    [cell configureWithImagePath:@"UserIcon" placeholderText:@"Full Name" lastRow:NO];
                    return cell;
                case 1:
                    [cell configureWithImagePath:@"EmailIcon" placeholderText:@"Email Address" lastRow:YES];
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
                    [cell configureWithImagePath:@"HomeIcon" placeholderText:@"House Name or No." lastRow:YES];
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
                    OrderDetailsDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSDELIVERYPICKERCELLIDENTIFIER" forIndexPath:indexPath];
                   // [cell configureWithDeliverySlotText:self.deliverySlot];
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
                    self.showPicker = YES;
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
    return @[@"Delivery from 6-7PM", @"Delivery from 7-8PM", @"Delivery from 8-9"];
}


- (void)setDeliverySlot:(NSString *)deliverySlot
{
    _deliverySlot = deliverySlot;
    
    [_tableView reloadData];
}


- (void)setShowPicker:(BOOL)showPicker
{
    [_tableView beginUpdates];
    
    _showPicker = showPicker;
    
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationTop];
    
    [_tableView endUpdates];
}

@end
