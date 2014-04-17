#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,width,100)];
  headerView.backgroundColor = [UIColor colorWithRed:0.61960784 green:0 blue:0.36470588 alpha:1.0];
 
  self.tableView.tableHeaderView = headerView;
  self.tableView.tableFooterView = [[UIView alloc] init];
  
  [super viewDidLoad];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row)
  {
    case 0:
     
      return [tableView dequeueReusableCellWithIdentifier:@"NEXTCELLIDENTIFIER" forIndexPath:indexPath];
      
      break;
  }
  
  assert(0);
  
  return nil;
}


@end
