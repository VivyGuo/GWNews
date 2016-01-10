//
//  NewsInfo.m
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "NewsInfo.h"

@implementation NewsInfo
- (NSString *)description{
    return  [NSString stringWithFormat:@"docid:%@\n,title:%@\n,digest:%@\n,imgsrc:%@\n,url3w:%@",self.ID,self.name,self.desc,self.iconUrl,self.detailUrl];
}

+(NSArray *)infosFromDict:(NSDictionary *)dict
{
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    NewsInfo *info = [[NewsInfo alloc] init];
    NSArray *newsArray = dict.allValues;//[dict objectForKey:@"T1351233117091"];
    for (NSDictionary *newItem in newsArray[0]) {
        //如果不存在hasCover且存在url_3w 添加 if([newsDict.allKeys containsObject:@"hasHead"]){
            if([newItem objectForKey:@"hasHead"]){
                continue;
            }
            if ([newItem objectForKey:@"url_3w"]) {
                info.ID = [newItem objectForKey:@"docid"];
                info.name = [newItem objectForKey:@"title"];
                info.desc = [newItem objectForKey:@"digest"];
                info.iconUrl = [newItem objectForKey:@"imgsrc"];
                info.detailUrl = [newItem objectForKey:@"url_3w"];
                [infos addObject:info];
            }
    }
    return infos;
}
@end
