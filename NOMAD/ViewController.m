#import "ViewController.h"
#import "TFHpple.h"
#import "Product.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *footerView;

@end

@implementation ViewController {
    
    __weak IBOutlet UITableView *_tableView;
    NSArray *_products;
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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



- (void)createItemWithURL:(NSURL*)url
{
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:url];
    
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    NSString *tutorialsXpathQueryString = @"//div[@class='content-wrapper']/ul/li/a";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement *element in tutorialsNodes) {
        Product *product = [[Product alloc] init];
        [mutableArray addObject:product];
        
        product.title = [[element firstChild] content];
        
        product.url = [element objectForKey:@"href"];
    }
    
    _products = mutableArray;
    [_tableView reloadData];
}



@end
