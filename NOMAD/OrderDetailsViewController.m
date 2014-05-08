//
//  OrderDetailsViewController.m
//  NOMAD
//
//  Created by Daren taylor on 24/04/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailsTextTableViewCell.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController {
    
    
    __weak IBOutlet NSLayoutConstraint *_buttonToBottomConstraint;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _buttonToBottomConstraint.constant = -100;
}
- (IBAction)cartButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showGetQuoteButton];
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
            return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                    OrderDetailsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSDELIVERYCELLIDENTIFIER" forIndexPath:indexPath];
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
                    
                    
                }
            }
            
        }
    }
}

- (void)showGetQuoteButton
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         _buttonToBottomConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                         
                     }];
}

@end
