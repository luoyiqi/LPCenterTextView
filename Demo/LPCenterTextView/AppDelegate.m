//
//  AppDelegate.m
//  LPCenterTextView
//
//  Created by Han Shuai on 15/11/29.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initUI];
    [self showMain];
    
    return YES;
}

- (void)initUI {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)showMain {
    ViewController *mainViewController = [[ViewController alloc] init];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navigationViewController;
    [self.window addSubview:navigationViewController.view];
    [self.window makeKeyAndVisible];
}

#pragma mark - Life Cycles

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
