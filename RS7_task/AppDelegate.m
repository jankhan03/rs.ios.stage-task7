//
//  AppDelegate.m
//  RS7_task
//
//  Created by Yan Khanetski on 4.07.21.
//

#import "AppDelegate.h"
#import "RSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RSViewController *vc = [[RSViewController alloc] initWithNibName: @"RSViewController" bundle:nil];
    [window setRootViewController:vc];
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
