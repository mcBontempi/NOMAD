//
//  OrderDetailsDeliveryPickerTableViewCell.h
//  NOMAD
//
//  Created by Daren David Taylor on 15/05/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsDeliveryPickerTableViewCell : UITableViewCell

- (void)configureWithDeliveryPickerDelegate:(id<UIPickerViewDelegate>)pickerDelegate;

@end
