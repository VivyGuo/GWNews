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

    self.viewControllers = [self getPageViewControllerArray];
}

//从Model层获取子视图，将子视图压入导航栈
- (NSArray *)getPageViewControllerArray{
    
    NSMutableArray *pageViewControllerArray = [NSMutableArray array];
    NSArray *pageInfoArray = [PageInfo getPageInfos];//实例方法可以调用类方法类方法内只能调用类方法，不能调用实例方法
    UIViewController *pageViewController = nil;
    UINavigationController *navigationPage = nil;
    
    for (PageInfo *pageInfo in pageInfoArray) {
        //如果该页不显示，跳过本轮，继续下一轮for
        if (!pageInfo.load) {
            continue;
        }
        
        //创建相应页面的ViewController，设置ViewController的title,image
        pageViewController = [[NSClassFromString(pageInfo.ID) alloc] init ];
        pageViewController.title = pageInfo.name;
        pageViewController.tabBarItem.image = [UIImage imageNamed:pageInfo.image];
        pageViewController.tabBarItem.selectedImage = [UIImage imageNamed:pageInfo.selectImage];
        
        navigationPage = [[UINavigationController alloc] initWithRootViewController:pageViewController];
        [pageViewControllerArray addObject:navigationPage];
    }
    return pageViewControllerArray;
}

@end
