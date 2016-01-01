//
//  NewsInfo.h
//  GWNews
//
//  Created by guowei on 15/12/17.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "BaseInfo.h"

@interface NewsInfo : BaseInfo

@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *iconUrl;
@property(nonatomic,strong) NSString *contentUrl;

@end
