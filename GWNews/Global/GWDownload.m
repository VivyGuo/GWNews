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
{
    self = [super init];
    if (self) {
        self.dictIcons = [[NSMutableDictionary alloc] init];
        
        _iconQueue = [[NSOperationQueue alloc] init];
        [_iconQueue setMaxConcurrentOperationCount:4];
    }
    
    return self;
}


#pragma mark - Download NewsIcon

- (void)cancelDownload
{
    [_iconQueue cancelAllOperations];
}

- (void)setNewsIcon:(NewsInfo *)newsInfo
          imageView:(UIImageView *)imageView
{
    NSString *file = [NSString stringWithFormat:NewsIconPrex, newsInfo.ID];
    UIImage *image = nil;
    
    file = [GWGlobal getCacheImage:file];
    
    if ([GWFileUtility isFileExist:file]) {
        image = [UIImage imageWithContentsOfFile:file];
        imageView.image = image;
    }
    else {
        imageView.image = [UIImage imageNamed:@"NewsDefault.png"];
//        [self downloadNewsIcon:newsInfo];
    }
}

- (void)downloadNewsIcon:(NewsInfo *)info
{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downNewsIconThread:) object:info];
    
    [_iconQueue addOperation:op];
}

- (void)downNewsIconThread:(NewsInfo *)info
{
    NSString *file = [NSString stringWithFormat:NewsIconPrex, info.ID];
    NSURL *url = [NSURL URLWithString:info.iconUrl];
    
    file = [GWGlobal getCacheImage:file];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSDictionary *dictInfo = @{
                                   @"info": info,
                                   @"data": image
                                   };
        SEL sel = @selector(notifyNewsIconDownload:);
        
        [data writeToFile:file atomically:YES];
        [self performSelectorOnMainThread:sel
                               withObject:dictInfo
                            waitUntilDone:NO];
    }
}

- (void)notifyNewsIconDownload:(NSDictionary *)dict
{
//    SendNotify(NofifyNewsIcon, dict)
}
@end
