#import <UIKit/UIKit.h>

@class Product;

@interface ItemDetailTableViewCell : UITableViewCell

- (void)configureWithProduct:(Product *)product;

@end
