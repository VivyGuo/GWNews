//
//  GWDownload.h
//  GWNews
//
//  Created by guowei on 16/1/11.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsInfo;
@interface GWDownload : NSObject

+ (GWDownload *)download;
- (void)cancelDownload;
- (void)setNewsImage:(UIImageView *)imageView object:(NewsInfo *)newsInfo;

@end
