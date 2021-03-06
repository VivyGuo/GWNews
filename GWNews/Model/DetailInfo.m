//
//  DetailInfo.m
//  GWNews
//
//  Created by guowei on 16/1/12.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "DetailInfo.h"
#import "DetailImageInfo.h"
@implementation DetailInfo

+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    DetailInfo *info = [[DetailInfo alloc] init];
    
    info.title = [dict objectForKey:@"title"]?([dict objectForKey:@"title"]):@"";
    info.source = [dict objectForKey:@"source"]?([dict objectForKey:@"source"]):@"";
    info.ptime = [dict objectForKey:@"ptime"]?([dict objectForKey:@"ptime"]):@"";;
    info.digest = [dict objectForKey:@"digest"]?([dict objectForKey:@"digest"]):@"";
    info.body = [dict objectForKey:@"body"]?([dict objectForKey:@"body"]):@"";
    info.ec = [dict objectForKey:@"ec"]?([dict objectForKey:@"ec"]):@"";
    info.sourceurl = [dict objectForKey:@"source_url"]?([dict objectForKey:@"source_url"]):@"";
    //图片数组
    NSArray *images =[dict objectForKey:@"img"];
    info.images = [DetailImageInfo infosFromArray:images];
    
    return info;
}

- (NSString *)description{
    return  [NSString stringWithFormat:@"title:%@,\nsource:%@,\ndigest:%@,\nptime:%@,\nec:%@,\nsourceurl:%@,\nbody:%@",self.title,self.source,self.digest,self.ptime,self.ec,self.sourceurl,self.body];
}
@end
