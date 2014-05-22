#import <UIKit/UIKit.h>

@protocol OrderDetailsPostcodeTableViewCellDelegate;

@interface OrderDetailsPostcodeTableViewCell : UITableViewCell
- (void)configureWithlastRow:(BOOL)lastRow delegate:(id<OrderDetailsPostcodeTableViewCellDelegate>) delegate;
- (void)resignResponder;
- (void)becomeResponder;

- (NSString *)fieldText;

@end
