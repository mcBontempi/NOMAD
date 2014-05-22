#import "AppDelegate.h"
#import <UIKit/UIPasteboard.h>
#import "ViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>


@implementation AppDelegate {
  ViewController *_viewController;
}

- (void)testPostcode
{
    
    NSString *baseURLString = @"https://api.ideal-postcodes.co.uk:443";
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSDictionary *parameters = @{@"api_key": @"ak_hvhc4kd1FPe2RMqfDybAnJwfnKM5j"};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    
    [manager GET:@"/v1/postcodes/ID11QD/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
   
    //good
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Postcode"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self testPostcode];
    
    
    
  [[UIApplication sharedApplication] setStatusBarHidden:YES
                                          withAnimation:UIStatusBarAnimationFade];
  
  _viewController =  (ViewController*)self.window.rootViewController;
  
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  UIPasteboard *pb = [UIPasteboard generalPasteboard];
  NSString *text =  pb.string;
  
  if (text.length) {
    [_viewController textPasted:(NSString *)text];
  }
}

@end
