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
    self.viewControllers = [PageInfo getPageViewControllerArray];
}

@end
