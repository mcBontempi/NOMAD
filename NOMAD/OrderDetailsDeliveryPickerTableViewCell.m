//
//  OrderDetailsDeliveryPickerTableViewCell.m
//  NOMAD
//
//  Created by Daren David Taylor on 15/05/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import "OrderDetailsDeliveryPickerTableViewCell.h"

@implementation OrderDetailsDeliveryPickerTableViewCell {
    __weak IBOutlet UIPickerView *_deliveryPicker;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
   
    [_deliveryPicker setBackgroundColor:[UIColor whiteColor]];
}

- (void)configureWithDeliveryPickerDelegate:(id<UIPickerViewDelegate>)pickerDelegate
{
    _deliveryPicker.delegate = pickerDelegate;
}

- (void)reloadPicker
{
    
    [_deliveryPicker reloadAllComponents];
}

@end
