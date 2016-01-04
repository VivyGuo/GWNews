//
//  ColumnInfo.h
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "BaseInfo.h"

@interface ColumnInfo : BaseInfo

@property(nonatomic,copy) NSString      *urlString;
@property(nonatomic,copy) NSString      *replyUrl;

+ (NSMutableArray *)getColumnInfos;

@end
