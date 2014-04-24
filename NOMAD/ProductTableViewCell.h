#import <UIKit/UIKit.h>

@class Product;

@interface ProductTableViewCell : UITableViewCell

- (void)configureWithProduct:(Product *)product;

@end
