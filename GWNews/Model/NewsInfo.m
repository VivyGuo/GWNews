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
     //从headline/T1351233117091  截取 T1351233117091 componentsSeparatedByString:@"/"
    //获取dict中所有values
    NSArray *newsArray = dict.allValues; 
    
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    NewsInfo *info = nil;
    
    for (NSDictionary *newItem in newsArray[0]) {
        //如果不存在hasCover且存在url_3w 添加 if([newsDict.allKeys containsObject:@"hasHead"]){
            if([newItem objectForKey:@"hasHead"]){
                continue;
            }
            if ([newItem objectForKey:@"url_3w"]) {
                info = [[NewsInfo alloc] init];
                info.ID = [newItem objectForKey:@"docid"];
                info.name = [newItem objectForKey:@"title"];
                info.desc = [newItem objectForKey:@"digest"];
                info.iconUrl = [newItem objectForKey:@"imgsrc"];
                info.contentUrl = [newItem objectForKey:@"url_3w"];
                [infos addObject:info];
            }
    }
    return infos;
}
@end
