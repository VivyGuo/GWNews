//
//  BaseInfo.m
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "BaseInfo.h"

@implementation BaseInfo
/*
 @brief Dictionary turn to object array
 */
//Return object by the given dictionary
+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    BaseInfo *info = [[BaseInfo alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    
    return info;
}
//Return object array by the given dictionary
+ (NSArray *)infosFromDict:(NSDictionary *)dict
{
    NSArray *array = [dict objectForKey:@"data"];
    return [[self class] infosFromArray:array];
}
//Return object array by the given array
+ (NSArray *)infosFromArray:(NSArray *)array
{
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in array)
    {
        [infos addObject:[[self class] infoFromDict:dict]];
    }
    if (infos.count <= 0) {
        infos = nil;
    }
    return infos;
}


@end
