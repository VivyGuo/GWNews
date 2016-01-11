//
//  DetailInfo.h
//  GWNews
//
//  Created by guowei on 16/1/12.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "BaseInfo.h"

@interface DetailInfo : BaseInfo

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *source;
@property(nonatomic, strong) NSString *ptime;
@property(nonatomic, strong) NSString *digest;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, strong) NSString *ec;
@property(nonatomic, strong) NSString *sourceurl;
@property(nonatomic, strong) NSArray  *images;

@end
