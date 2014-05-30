#import <UIKit/UIKit.h>

@protocol OrderDetailsTextTableViewCellDelegate;

@interface OrderDetailsTextTableViewCell : UITableViewCell
- (void)configureWithImagePath:(NSString *)imagePath placeholderText:(NSString *)placeholderText lastRow:(BOOL)lastRow delegate:(id<OrderDetailsTextTableViewCellDelegate>)delegate keyboardType:(enum UIKeyboardType)keyboardType autoCapitalisationType:(UITextAutocapitalizationType)autoCapitalisationType;

- (void)resignResponder;
- (void)becomeResponder;
@end
