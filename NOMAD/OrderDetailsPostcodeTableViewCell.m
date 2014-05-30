#import "OrderDetailsPostcodeTableViewCell.h"
#import "OrderDetailsPostcodeTableViewCellDelegate.h"

@interface OrderDetailsPostcodeTableViewCell () <UITextFieldDelegate>

@end

@implementation OrderDetailsPostcodeTableViewCell {
    __weak IBOutlet UITextField *_textField;
    __weak IBOutlet UIImageView *_cellOutlineBottom;
    
    __weak id<OrderDetailsPostcodeTableViewCellDelegate> _delegate;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _textField.delegate = self;
}

- (void)configureWithlastRow:(BOOL)lastRow delegate:(id<OrderDetailsPostcodeTableViewCellDelegate>) delegate
{
    _textField.placeholder = @"Post Code";
    _cellOutlineBottom.hidden = !lastRow;
    _delegate = delegate;
    
    _textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
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
    [_delegate returnKeyPressedFromOrderDetailsPostcodeTableViewCell:self];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate beganEditingOrderDetailsPostcodeTableViewCell:self];
}

- (NSString *)fieldText
{
    return _textField.text;
}

- (IBAction)findTapped:(id)sender
{
    [_delegate findTappedOnOrderDetailsPostcodeTableViewCell:self];
}

@end
