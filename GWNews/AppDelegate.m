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
- (void)dictTest{
    NSDictionary *dict = @{@"T1348647853363":@[@{@"hasCover":@"false"},@{@"url_3w":@"url3wcontent"},@{@"digest":@"digestcontent"}]};
    NSArray  *array =  dict.allValues;
    for(NSDictionary *obj in array){
        NSLog(@"%@",obj);

    }
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
