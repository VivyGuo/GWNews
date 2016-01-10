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

@property(nonatomic, strong)NSMutableDictionary *dictIcons;

+ (GWDownload *)download;

- (void)cancelDownload;
- (void)setNewsIcon:(NewsInfo *)newsInfo
          imageView:(UIImageView *)imageView;

@end
