#import "OrderDetailsDeliveryTableViewCell.h"

@implementation OrderDetailsDeliveryTableViewCell {

    __weak IBOutlet UILabel *_deliverySlotLabel;

}

- (void)configureWithDeliverySlotText:(NSString *)deliverySlotText
{
    _deliverySlotLabel.text = deliverySlotText;
}

@end
