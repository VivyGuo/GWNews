//
//  GWGetDetail.m
//  GWNews
//
//  Created by guowei on 16/1/12.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWGetDetail.h"
#import "DetailInfo.h"
@implementation GWGetDetail
- (void)parseSuccessData:(NSData *)data{
   
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [GWJsonUtility jsonValueFromString:jsonString];
    
    NSString *articleID = [_opInfo objectForKey:@"docid"];
    NSDictionary *dictResult = [dict objectForKey:articleID];
    
    if (dictResult != nil) {
        DetailInfo *info = [DetailInfo infoFromDict:dictResult];
        [_delegate operation:self successWithData:info];
    }
}
@end
