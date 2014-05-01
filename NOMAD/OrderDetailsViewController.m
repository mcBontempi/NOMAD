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
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  switch (section) {
    case 0:
      return 2;
    case 1:
      return 1;
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0:
    {
      OrderDetailsTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSTEXTCELLIDENTIFIER" forIndexPath:indexPath];
      
      switch (indexPath.row) {
        case 0:
          [cell configureWithImage:@"" placeholderText:@"Full Name"];
          return cell;
        case 1:
          [cell configureWithImage:@"" placeholderText:@"Email Address"];
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
          [cell configureWithImage:@"" placeholderText:@"House Name or No."];
          return cell;
        }
      }
      break;
    }
  }
  return nil;
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
