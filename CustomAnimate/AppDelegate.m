//
//  AppDelegate.m
//  CustomAnimate
//
//  Created by meitu on 16/7/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "AppDelegate.h"

#import "OnePushViewController.h"

#import "OnePresentViewController.h"

#import "CollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController * oneNC_PUSH = [[UINavigationController alloc] initWithRootViewController:[[OnePushViewController alloc] init]];
    oneNC_PUSH.tabBarItem.title = @"PUSH控制器";
    
    OnePresentViewController * onenc_PRESENT = [[OnePresentViewController alloc] init];
    onenc_PRESENT.tabBarItem.title = @"PRESENT控制器";
    
    UINavigationController * collectionNC_PUSH = [[UINavigationController alloc] initWithRootViewController:[[CollectionViewController alloc] init]];
    [collectionNC_PUSH.tabBarItem setTitle:@"系统相册动画"];

    UITabBarController * tabTC = [[UITabBarController alloc] init];
    [tabTC setViewControllers:@[oneNC_PUSH, onenc_PRESENT, collectionNC_PUSH]];
    [self.window setRootViewController:tabTC];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
