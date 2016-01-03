//
//  AdvertPage.m
//  GWNews
//
//  Created by guowei on 15/12/31.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "AdvertPage.h"
#import "AppDelegate.h"
#import "GWGetAdvert.h"
#import "GWGetImage.h"
#import "GWDate.h"
#import "GWAppSetting.h"


@implementation AdvertPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAdvert];
}
+ (BOOL)canShowAdvertPage{
    NSString *dateString = [GWAppSetting getValue:AdvertKey];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:[GWDate dateFromStringYMDHMS:dateString]];
    //一小时内不再显示广告页
    if (interval < AdvertCheckTime) {
        return NO;
    }
    return YES;
}
+ (void)showAdvertPage{
    //记录图片第一次显示时间
    [GWAppSetting setValue:[GWDate stringFromDateYMDHMS:[NSDate date]] forKey:AdvertKey];
    
    AdvertPage *advertController = [[AdvertPage alloc] init];
    UIWindow *window = [AppDelegate appDeg].window;
    
    if (window.rootViewController != nil) {
        advertController.view.frame = window.rootViewController.view.bounds;;
        [window.rootViewController.view addSubview:advertController.view];
    }
    else {
        window.rootViewController = advertController;
        [window makeKeyAndVisible];
    }
}
//网络请求操作获取广告信息
- (void)getAdvert
{
    // 本地已经存在，取本地广告图片，显示一段时间后隐藏广告显示主页
    if ([self checkLanchExist]) {
        return;
    }
    
    //AdvertURL:http://127.0.0.1//NewsReader/advert.json?width=%ld&height=%ld
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *url = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    
    NSDictionary *dictInfo = @{@"url":url};
    _operation = [[GWGetAdvert alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
    
}

- (BOOL)checkLanchExist{
    NSString *fileName = [GWDate stringFromDateYMD:[NSDate date]];
    NSString *filePath = [GWGlobal getCacheImage:fileName];
    
    if ([GWFileUtility isFileExist:filePath]) {
        _imageView.image = [UIImage imageWithContentsOfFile:filePath];
        [self performSelector:@selector(hideLaunch) withObject:nil afterDelay:AdvertDelayTime];
        return YES;
    }
    return NO;
}
//隐藏广告页面
- (void)hideLaunch{
    if (self.view.superview != [AppDelegate appDeg].window) {
        [self.view removeFromSuperview];
    }else{
        [[AppDelegate appDeg] showHomePage];
    }
}

#pragma mark - GWNetworkOperationDataDelegate methods

- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
    if ([operation isMemberOfClass:[GWGetAdvert class]]) {
        [self getLaunchImage:(NSString *)data];
    }
    if ([operation isMemberOfClass:[GWGetImage class]]) {
        [self setLaucnImage:data];
        [self performSelector:@selector(hideLaunch) withObject:nil afterDelay:AdvertDelayTime];
    }
}
//网络请求错误处理,不显示广告页，显示主页
- (void)operation:(GWNetworkOperation *)operation failWithErrorMessage:(NSString *)message{
    BASE_ERROR_FUN(message);
    [self hideLaunch];
}

- (void)getLaunchImage:(NSString *)url{
    NSDictionary *dictInfo = @{@"url":url};
    _operation = [[GWGetImage alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}
//显示广告图片，存入缓存文件
- (void)setLaucnImage:(NSData *)data
{
    NSString *fileName = [GWDate stringFromDateYMD:[NSDate date]];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image!=nil) {
        _imageView.image = image;
        [data writeToFile:[GWGlobal getCacheImage:fileName] atomically:YES];//Library/.GWNews/CacheImages
//Library/Caches   与NSHomeDirectory()/Library/Caches等价
//[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
    }
}
@end
