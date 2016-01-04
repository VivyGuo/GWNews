//
//  HomeTabBarController.m
//  GWNews
//
//  Created by guowei on 16/1/3.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "HomeTabBarController.h"
#import "PageInfo.h"

@implementation HomeTabBarController

- (id)init{
    self = [super init];
    if (self) {
        [self addViewControllers];
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//TabBarController添加子项
- (void)addViewControllers{
    self.tabBar.tintColor = [UIColor redColor];
    //[UIColor colorWithRed:183/255.0 green:20/255.0 blue:28/255.0 alpha:1];
    //[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];

    self.viewControllers = [PageInfo getPageViewControllerArray];
}

@end
