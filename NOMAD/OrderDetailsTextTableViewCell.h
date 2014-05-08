//
//  OrderDetailsTextTableViewCell.h
//  NOMAD
//
//  Created by Daren taylor on 24/04/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsTextTableViewCell : UITableViewCell
- (void)configureWithImagePath:(NSString *)path placeholderText:(NSString *)placeholderText lastRow:(BOOL)lastRow;
@end
