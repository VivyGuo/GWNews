//
//  ColumnInfo.m
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "ColumnInfo.h"

@implementation ColumnInfo

+ (ColumnInfo *)infoFromDict:(NSDictionary *)dict{
    ColumnInfo *info = [[ColumnInfo alloc] init];
    info.name = [dict objectForKey:@"title"];
    info.urlString = [dict objectForKey:@"urlString"];
    info.replyUrl = [dict objectForKey:@"replyUrl"];
    return info;
}

//从配置文件中读取页面类数据，创建ColumnInfo,返回ColumnInfo数组
+ (NSArray *)getColumnInfos{
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"NewsColumn" ofType:@"plist"];
    NSArray  *columConfigs = [NSArray arrayWithContentsOfFile:configFile];
    NSMutableArray *columnInfoArray = [[NSMutableArray alloc] init];
    
    if (columConfigs.count <= 0) {
        BASE_ERROR_FUN(@"NewsColumn.plist无数据");
    }
    for (NSDictionary *columnDict in columConfigs) {
        [columnInfoArray addObject:[ColumnInfo infoFromDict:columnDict]];
    }
    
    return columnInfoArray;
}


@end
