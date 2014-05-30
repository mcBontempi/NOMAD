//
//  OrderDetailsPostcodeTableViewCellDelegate.h
//  NOMAD
//
//  Created by Daren David Taylor on 15/05/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderDetailsPostcodeTableViewCellDelegate <NSObject>

- (void)returnKeyPressedFromOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender;

- (void)beganEditingOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender;

- (void)findTappedOnOrderDetailsPostcodeTableViewCell:(OrderDetailsPostcodeTableViewCell *)sender;

@end
