//
//  PageInfo.m
//  GWNews
//
//  Created by guowei on 16/1/4.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "PageInfo.h"

@implementation PageInfo

+ (PageInfo *)infoFromDict:(NSDictionary *)dict{
    PageInfo *info = [[PageInfo alloc] init];
    info.ID = [dict objectForKey:@"className"];
    info.name = [dict objectForKey:@"title"];
    info.image = [dict objectForKey:@"image"];
    info.selectImage = [dict objectForKey:@"selectImage"];
    info.load = [[dict objectForKey:@"load"] boolValue];
    return info;
}

//从配置文件中读取页面类数据，创建PageInfo,返回PageInfo数组
+ (NSArray *)getPageInfoArray{
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"TabBarPages" ofType:@"plist"];
    NSArray  *pageConfigs = [NSArray arrayWithContentsOfFile:configFile];
    NSMutableArray *pageInfoArray = [[NSMutableArray alloc] init];
    
    if (pageConfigs.count <= 0) {
        BASE_ERROR_FUN(@"TabBarPages.plist无数据");
    }
    for (NSDictionary *pageDict in pageConfigs) {
        [pageInfoArray addObject:[PageInfo infoFromDict:pageDict]];
    }
    
    return pageInfoArray;
}
//返回带导航条的相应的各个页面的ViewController
+ (NSArray *)getPageViewControllerArray{
    
    NSMutableArray *pageViewControllerArray = [NSMutableArray array];
    NSArray *pageInfoArray = [PageInfo getPageInfoArray];//类方法内只能调用类方法，不能调用实例方法
    UIViewController *pageViewController = nil;
    UINavigationController *navigationPage = nil;
    
    for (PageInfo *pageInfo in pageInfoArray) {
        //创建相应页面的ViewController，设置ViewController的title,image
        pageViewController = [[NSClassFromString(pageInfo.ID) alloc] init ];
        pageViewController.title = pageInfo.name;
        pageViewController.tabBarItem.image = [UIImage imageNamed:pageInfo.image];
        
        navigationPage = [[UINavigationController alloc] initWithRootViewController:pageViewController];
        [pageViewControllerArray addObject:navigationPage];
    }
    return pageViewControllerArray;
}

@end
