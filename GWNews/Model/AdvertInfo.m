//
//  AdvertInfo.m
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "AdvertInfo.h"

@implementation AdvertInfo

+(instancetype)infoFromDict:(NSDictionary *)dict
{
    NSDictionary *advertDic = [dict objectForKey:@"ads"][0];
    
    AdvertInfo *info = [[AdvertInfo alloc] init];
    info.ID = [advertDic objectForKey:@"id"];
    info.imageUrl = [advertDic objectForKey:@"res_url"][0];
    return info;
}
@end
