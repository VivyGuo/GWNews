//
//  DetailInfo.m
//  GWNews
//
//  Created by guowei on 16/1/12.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "DetailInfo.h"

@implementation DetailInfo
+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    DetailInfo *info = [[DetailInfo alloc] init];
    
    info.title = [dict objectForKey:@"title"];
    info.source = [dict objectForKey:@"source"];
    info.ptime = [dict objectForKey:@"ptime"];
    info.digest = [dict objectForKey:@"digest"];
    info.body = [dict objectForKey:@"body"];
    info.ec = [dict objectForKey:@"ec"];
    info.sourceurl = [dict objectForKey:@"source_url"];
    
//    NSArray *images =[dict objectForKey:@"img"];
//    info.images = [ContentImageInfo arrayFromArray:images];
    
    return info;
}
@end
