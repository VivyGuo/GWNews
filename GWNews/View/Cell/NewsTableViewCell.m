//
//  NewsTableViewCell.m
//  GWNews
//
//  Created by guowei on 16/1/8.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsInfo.h"
#import "GWGetImage.h"
#import "GWDownload.h"

@implementation NewsTableViewCell

- (void)initCell
{//添加观察者，图片下载完成更新cell
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadIcon:) name:NofifyNewsIcon object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCellData:(NewsInfo *)info
{
    self.cellInfo = info;
    self.titleLabel.text = info.name;
    
    self.descLabel.numberOfLines = 2;
    self.descLabel.text = info.desc;
    //下载图片方法三：多线程异步下载图片
    [[GWDownload download] setNewsImage:self.imageIcon object:info];
}

//接受通知发生改变，更新图片
- (void)downloadIcon:(NSNotification *)notification
{
    NSDictionary *dict = [notification object];
    NewsInfo *info = [dict objectForKey:@"info"];
    
    if ([info.ID isEqualToString:self.cellInfo.ID]) {
        UIImage *image = [dict objectForKey:@"data"];
        self.imageIcon.image = image;
    }
}

//- (void)setNewsImage:(NSString *)imageUrl{
    //下载图片方法一：在主线程中下载，速度巨慢并且页面卡顿
    //    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    //    self.imageIcon.image = [UIImage imageWithData:imageData];
    //下载图片方法二：通过委托模式
//    NSDictionary *dictInfo = @{@"url":imageUrl};
//    GWNetworkOperation *operation = [[GWGetImage alloc] initWithDelegate:self opInfo:dictInfo];
//    [operation executeOp];
//}
//- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
//    self.imageIcon.image = [UIImage imageWithData:data];
//}
//- (void)operation:(GWNetworkOperation *)operation failWithErrorMessage:(NSString *)message{
//    BASE_ERROR_FUN(message);
//}


@end
