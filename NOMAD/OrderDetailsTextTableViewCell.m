#import "OrderDetailsTextTableViewCell.h"
#import "OrderDetailsTextTableViewCellDelegate.h"

@interface OrderDetailsTextTableViewCell () <UITextFieldDelegate>

@end

@implementation OrderDetailsTextTableViewCell {
    __weak IBOutlet UIImageView *_iconImageView;
    __weak IBOutlet UITextField *_textField;
    __weak IBOutlet UIImageView *_cellOutlineBottom;
    
    __weak id<OrderDetailsTextTableViewCellDelegate> _delegate;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _textField.delegate = self;
}

- (void)configureWithImagePath:(NSString *)imagePath placeholderText:(NSString *)placeholderText lastRow:(BOOL)lastRow delegate:(id<OrderDetailsTextTableViewCellDelegate>)delegate
{
    _iconImageView.image = [UIImage imageNamed:imagePath];
    _textField.placeholder = placeholderText;
    _cellOutlineBottom.hidden = !lastRow;
    _delegate = delegate;
}

- (void)becomeResponder
{
    [_textField becomeFirstResponder];
}

- (void)resignResponder
{
    [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)txtField
{
    [_delegate returnKeyPressedFromOrderDetailsTextTableViewCell:self];
    return NO;
}

@end
