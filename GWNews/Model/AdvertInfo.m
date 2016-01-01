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
//    info.ID = [dict objectForKey:@"id"];
//    info.name = [dict objectForKey:@"name"];
//    info.imageUrl = [dict objectForKey:@"imageurl"];
//    info.linkUrl = [dict objectForKey:@"linkurl"];
    
    info.ID = [advertDic objectForKey:@"id"];
    info.imageUrl = [advertDic objectForKey:@"res_url"][0];
    //    advert.linkUrl = [[advertDic objectForKey:@"actions_params"] objectForKey:@"link_url"];
    return info;
}
@end
