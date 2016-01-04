//
//  NewsInfo.m
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "NewsInfo.h"

@implementation NewsInfo
+(instancetype)infoFromDict:(NSDictionary *)dict
{
    NewsInfo *info = [[NewsInfo alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.desc = [dict objectForKey:@"desc"];
    info.iconUrl = [dict objectForKey:@"iconurl"];
    info.contentUrl = [dict objectForKey:@"contenurl"];
    return info;
}
@end
