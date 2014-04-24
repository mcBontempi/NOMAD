#import "ProductTableViewCell.h"
#import "Product.h"

@implementation ProductTableViewCell {
  
  __weak IBOutlet UILabel *_titleLabel;
}

- (void)configureWithProduct:(Product *)product
{
  _titleLabel.text = product.title;
}

@end
