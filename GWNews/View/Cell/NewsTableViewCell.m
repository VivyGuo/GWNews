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

@interface NewsTableViewCell()<GWNetworkOperationDelegate>

@end

@implementation NewsTableViewCell
//下载图片
- (void)initCell
{
//    RegisterNotify(NofifyNewsIcon, @selector(downloadIcon:));
}
//
//- (void)dealloc
//{
//    RemoveNofify;
//}

- (void)setCellData:(NewsInfo *)info
{
    self.cellInfo = info;
    self.titleLabel.text = info.name;
    
    self.descLabel.numberOfLines = 2;
    self.descLabel.text = info.desc;
    [self setNewsImage:info.iconUrl];
    //    [[FxDownload download] setNewsIcon:info imageView:_imageView];
}
- (void)setNewsImage:(NSString *)imageUrl{
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//    self.imageIcon.image = [UIImage imageWithData:imageData];//这种方法巨慢，并且卡顿
    
    NSDictionary *dictInfo = @{@"url":imageUrl};
    GWNetworkOperation *operation = [[GWGetImage alloc] initWithDelegate:self opInfo:dictInfo];
    [operation executeOp];
}

- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
    self.imageIcon.image = [UIImage imageWithData:data];
}
- (void)operation:(GWNetworkOperation *)operation failWithErrorMessage:(NSString *)message{
    BASE_ERROR_FUN(message);
}



//- (void)downloadIcon:(NSNotification *)notification
//{
//    NSDictionary *dict = [notification object];
//    NewsInfo *info = [dict objectForKey:@"info"];
//    
//    if ([info.ID isEqualToString:self.cellInfo.ID]) {
//        UIImage *image = [dict objectForKey:@"data"];
//        _imageView.image = image;
//    }
//}
@end
