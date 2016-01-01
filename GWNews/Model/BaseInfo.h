//
//  BaseInfo.h
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseInfo : NSObject
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *name;

+ (instancetype)infoFromDict:(NSDictionary *)dict;
+ (NSArray *)infosFromDict:(NSDictionary *)dict;
+ (NSArray *)infosFromArray:(NSArray *)array;

@end
