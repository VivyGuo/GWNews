//
//  GwGetNews.m
//  GWNews
//
//  Created by guowei on 15/12/21.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWGetNews.h"
#import "NewsInfo.h"
@implementation GWGetNews
//将数据解析到Model层NewsInfo
- (void)parseSuccessData:(NSData *)data{
    //NSUTF8StringEncoding会出现data转换为空的情况,NSASCIIStringEncoding
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [GWJsonUtility jsonValueFromString:jsonString];
    
    NSArray *newsInfo = [NewsInfo infosFromDict:dict];
    [_delegate operation:self successWithData:newsInfo];
}
@end
