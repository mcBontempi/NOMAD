#import "AppDelegate.h"
#import <UIKit/UIPasteboard.h>
#import "ViewController.h"

@implementation AppDelegate {
    ViewController *_viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    _viewController =  (ViewController*)self.window.rootViewController;
    
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    NSString *text =  pb.string;
    
    _viewController.
    
    
}


@end
