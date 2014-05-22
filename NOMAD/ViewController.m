#import "ViewController.h"
#import "TFHpple.h"
#import "Product.h"
#import "ProductTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *footerView;

@end

@implementation ViewController {
  __weak IBOutlet UITableView *_tableView;
  __weak IBOutlet NSLayoutConstraint *_buttonToBottomConstraint;
  
  NSMutableArray *_products;
}

#pragma mark - Accessors

- (UIView *)footerView
{
  if (!_footerView) {
    _footerView = [[UIView alloc] init];
  }
  return _footerView;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _products = [@[] mutableCopy];
  
  _tableView.tableFooterView = self.footerView;
  
  _buttonToBottomConstraint.constant = -100;
    
    
//[self showNextButton];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ITEMDETAILCELLIDENTIFIER" forIndexPath:indexPath];
  
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  [cell configureWithProduct:_products[indexPath.row]];
  
  return cell;
}

- (void)addItemWithURL:(NSURL*)url
{
  [_tableView beginUpdates];
  
  NSData *htmlData = [NSData dataWithContentsOfURL:url];
  
  TFHpple *parser = [TFHpple hppleWithHTMLData:htmlData];
  
  NSString *xpathQueryString = @"//title";
  NSArray *nodes = [parser searchWithXPathQuery:xpathQueryString];
  
  for (TFHppleElement *element in nodes) {
    Product *product = [[Product alloc] init];
    product.title = [[element firstChild] content];
    [_products insertObject:product atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_tableView insertRowsAtIndexPaths:@[indexPath]   withRowAnimation:UITableViewRowAnimationTop];
  }
  
  [_tableView endUpdates];
  
  [self showNextButton];
}

- (void)showNextButton
{
  [UIView animateWithDuration:1.0
                   animations:^{
                     
                     _buttonToBottomConstraint.constant = 0;
                     [self.view layoutIfNeeded];
                     
                   }];
}

#pragma mark - public methods

- (void)textPasted:(NSString *)text
{
  NSURL *url = [[NSURL alloc] initWithString:text];
  
  if (url) {
    [self addItemWithURL:url];
  }
}

@end
