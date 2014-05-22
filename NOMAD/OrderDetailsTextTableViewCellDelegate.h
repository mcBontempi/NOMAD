//
//  OrderDetailsTextTableViewCellDelegate.h
//  NOMAD
//
//  Created by Daren David Taylor on 15/05/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderDetailsTextTableViewCellDelegate <NSObject>

- (void)returnKeyPressedFromOrderDetailsTextTableViewCell:(OrderDetailsTextTableViewCell *)sender;

@end
