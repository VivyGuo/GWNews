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
+ (NSArray *)getPageInfos{
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

@end
