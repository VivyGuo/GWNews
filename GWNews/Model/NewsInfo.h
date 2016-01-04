//
//  NewsInfo.h
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "BaseInfo.h"

@interface NewsInfo : BaseInfo

@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *iconUrl;
@property(nonatomic,copy) NSString *contentUrl;

@end
