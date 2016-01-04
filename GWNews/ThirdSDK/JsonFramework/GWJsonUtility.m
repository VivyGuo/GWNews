//
//  GWJsonUtility.m
//  GWCore
//
//  Created by Jinbo He on 12-7-12.
//  Copyright (c) 2012年 KuaiPan. All rights reserved.
//

#import "GWJsonUtility.h"
#import "GWJsonWriter.h"
#import "GWJsonParser.h"

@implementation GWJsonUtility
//从Json格式字符串中解析对象，如Dictionary,Array
+ (id)jsonValueFromString:(NSString *)jsonString
{
    GWJsonParser *jsonParser = [GWJsonParser new];
    id repr = [jsonParser objectWithString:jsonString];
    
    if (!repr) {
        BASE_INFO_FUN(@"不是合法的JSON格式");
        BASE_INFO_FUN(jsonString);
    }

    [jsonParser release];
    return repr;
}
//将对象转为Json格式字符串
+ (NSString *)jsonValueFromObject:(id)object
{
    GWJsonWriter *jsonWriter = [GWJsonWriter new]; 
    NSString *json = [jsonWriter stringWithObject:object];
    
    if (!json) {
        BASE_INFO_FUN(@"对象不能转换为Json格式字符串");
        BASE_INFO_FUN([jsonWriter errorTrace]);
    }
    
    [jsonWriter release];
    return json;
}

@end
