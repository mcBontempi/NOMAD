#import "ItemDetailTableViewCell.h"
#import "Product.h"

@implementation ItemDetailTableViewCell {
  
  __weak IBOutlet UILabel *_titleLabel;
}

- (void)configureWithProduct:(Product *)product
{
  _titleLabel.text = product.title;
}

@end
