//
//  DetailImageInfo.m
//  GWNews
//
//  Created by guowei on 16/1/19.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "DetailImageInfo.h"

@implementation DetailImageInfo

+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    DetailImageInfo *info = [[DetailImageInfo alloc] init];
    
    info.ref = [dict objectForKey:@"ref"];
    info.pixel = [dict objectForKey:@"pixel"];
    info.alt = [dict objectForKey:@"alt"];
    info.src = [dict objectForKey:@"src"];
    
    return info;
}

@end
