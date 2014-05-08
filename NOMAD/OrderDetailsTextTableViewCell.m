#import "OrderDetailsTextTableViewCell.h"

@implementation OrderDetailsTextTableViewCell {
  __weak IBOutlet UIImageView *_iconImageView;
  __weak IBOutlet UITextField *_textField;
    __weak IBOutlet UIImageView *_cellOutlineBottom;
}

- (void)configureWithImagePath:(NSString *)imagePath placeholderText:(NSString *)placeholderText lastRow:(BOOL)lastRow
{
  _iconImageView.image = [UIImage imageNamed:imagePath];
  _textField.placeholder = placeholderText;
    _cellOutlineBottom.hidden = !lastRow;
}

@end
