//
//  BaseInfo.h
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseInfo : NSObject
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;

+ (instancetype)infoFromDict:(NSDictionary *)dict;
+ (NSArray *)infosFromDict:(NSDictionary *)dict;
+ (NSArray *)infosFromArray:(NSArray *)array;

@end
