//
//  OrderDetailsViewController.h
//  NOMAD
//
//  Created by Daren taylor on 24/04/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSString *deliverySlot;

@end
