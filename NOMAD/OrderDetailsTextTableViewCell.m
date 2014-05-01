#import "OrderDetailsTextTableViewCell.h"

@implementation OrderDetailsTextTableViewCell {
  __weak IBOutlet UIImageView *_iconImageView;
  __weak IBOutlet UITextField *_textField;
}

- (void)configureWithImage:(NSString *)imagePath placeholderText:(NSString *)placeholderText
{
  _iconImageView.image = [UIImage imageNamed:imagePath];
  _textField.placeholder = placeholderText;
}

@end
