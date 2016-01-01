//
//  GwGetAdvert.m
//  GWNews
//
//  Created by guowei on 15/12/21.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWGetAdvert.h"
#import "AdvertInfo.h"

@implementation GWGetAdvert


- (void)parseSuccessData:(NSData *)data{
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [GWJsonUtility jsonValueFromString:jsonString];
    AdvertInfo *advertInfo = [AdvertInfo infoFromDict:dict];
//    [_delegate opSuccess:advertInfo.imageUrl];
    [_delegate operation:self successWithData:advertInfo.imageUrl];
}

@end
