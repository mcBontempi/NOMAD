#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *footerView;

@end

@implementation ViewController {
  
  __weak IBOutlet UITableView *_tableView;
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
  _tableView.tableFooterView = self.footerView;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row)
  {
    case 0:
    case 1:
      return 75;
    case 2:
      return 200;
    case 3:
    case 4:
      return 48;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row)
  {
    case 0:
    case 1:
      return [tableView dequeueReusableCellWithIdentifier:@"ITEMDETAILCELLIDENTIFIER" forIndexPath:indexPath];
    case 2:
      return [tableView dequeueReusableCellWithIdentifier:@"SCHEDULECELLIDENTIFIER" forIndexPath:indexPath];
    case 3:
      return [tableView dequeueReusableCellWithIdentifier:@"NEXTCELLIDENTIFIER" forIndexPath:indexPath];
      
    case 4:
      return [tableView dequeueReusableCellWithIdentifier:@"SUPPORTCELLIDENTIFIER" forIndexPath:indexPath];
      
  }
  
  assert(0);
  
  return nil;
}


@end
