//
//  GWDownload.m
//  GWNews
//
//  Created by guowei on 16/1/11.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWDownload.h"
#import "NewsInfo.h"
@interface GWDownload ()
@property(nonatomic, strong) NSOperationQueue   *iconQueue;
@end

@implementation GWDownload
//单例模式，返回唯一一个对象
+ (GWDownload *)download
{
    static GWDownload *s_download = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s_download = [[GWDownload alloc] init];
    });
    
    return s_download;
}

- (id)init
{//初始化线程队列，设置线程总数,最多并发4个线程
    self = [super init];
    if (self) {
        _iconQueue = [[NSOperationQueue alloc] init];
        [_iconQueue setMaxConcurrentOperationCount:4];
    }
    
    return self;
}

- (void)cancelDownload
{
    [_iconQueue cancelAllOperations];
}

- (void)setNewsImage:(UIImageView *)imageView object:(NewsInfo *)newsInfo;
{
    NSString *file = [NSString stringWithFormat:NewsIconPrex, newsInfo.ID];
    file = [GWGlobal getCacheImage:file];
    //如果已缓存图片从本地获取，否则下载
    if ([GWFileUtility isFileExist:file]) {
        imageView.image = [UIImage imageWithContentsOfFile:file];
    }else {
        //设置默认图片
        imageView.image = [UIImage imageNamed:@"NewsDefault.png"];
        [self downloadIcon:newsInfo];
    }
}

- (void)downloadIcon:(NewsInfo *)info
{//开启线程下载
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadNewsIcon:) object:info];
    //添加到操作队列
    [_iconQueue addOperation:op];
}
//在子线程里下载图片
- (void)downloadNewsIcon:(NewsInfo *)info
{
    NSURL *url = [NSURL URLWithString:info.iconUrl];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        //创建缓存图片存放路径，将图片写入本地缓存
        NSString *file = [GWGlobal getCacheImage:[NSString stringWithFormat:NewsIconPrex, info.ID]];
        [data writeToFile:file atomically:YES];
        //生成ImageData返回给NewsCell
        UIImage *image = [UIImage imageWithData:data];
        NSDictionary *dictInfo = @{@"info": info,@"data": image};
        //在UI主线程更新cell，通过发送通知更新
        [self performSelectorOnMainThread: @selector(notifyNewsCellUpdateIcon:)
                               withObject:dictInfo
                            waitUntilDone:NO];
    }
}
//发送通知
- (void)notifyNewsCellUpdateIcon:(NSDictionary *)dict
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NofifyNewsIcon object:dict];
}
@end
