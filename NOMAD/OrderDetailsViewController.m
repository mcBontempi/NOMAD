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

@implementation OrderDetailsViewController

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  OrderDetailsViewController *cell = [tableView dequeueReusableCellWithIdentifier:@"ORDERDETAILSTEXTCELLIDENTIFIER" forIndexPath:indexPath];
  
 // [cell configureWithProduct:_products[indexPath.row]];
  
  return cell;
}


@end
