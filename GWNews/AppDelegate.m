//
//  AppDelegate.m
//  GWNews
//
//  Created by guowei on 15/12/8.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "AppDelegate.h"
#import "AdvertPage.h"
#import "HomeTabBarController.h"

@implementation AppDelegate

+ (AppDelegate *)appDeg
{
    return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}
//显示主页TabBarController
- (void)showHomePage{
    HomeTabBarController *page = [[HomeTabBarController alloc] init];
    self.window.rootViewController = page;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [AdvertPage showAdvertPage];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([AdvertPage canShowAdvertPage]) {
        [AdvertPage showAdvertPage];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
