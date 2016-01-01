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

@interface AdvertPage ()

@end

@implementation AdvertPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAdvert];
    
}
+ (BOOL)canShowAdvertPage{
    return YES;
}
+ (void)showAdvertPage{
//    [FxAppSetting setValue:[FxDate stringFromDateYMDHMS:[NSDate date]] forKey:AdvertKey];
    
    AdvertPage *controller = [[AdvertPage alloc] init];
    UIWindow *window = [AppDelegate appDeg].window;
    
    if (window.rootViewController != nil) {
        CGRect frame = window.rootViewController.view.bounds;
        
        controller.view.frame = frame;
        [window.rootViewController.view addSubview:controller.view];
    }
    else {
        window.rootViewController = controller;
        [window makeKeyAndVisible];
    }
}
//网络请求操作获取广告信息
- (void)getAdvert
{
    // 本地已经存在，取本地图片
//    if ([self checkLanchExist]) {
//        return;
//    }
    
    //AdvertURL:http://127.0.0.1//NewsReader/advert.json?width=%ld&height=%ld
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *url = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    
    NSDictionary *dictInfo = @{@"url":url};
    _operation = [[GWGetAdvert alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
    
}

- (BOOL)checkLanchExist{
    return NO;
}

#pragma mark - GWNetworkOperationDataDelegate methods
//
//- (void)opSuccess:(NSString *)url
//{
//    [self getLaunchImage:url];
//}
//
//- (void)opSuccessEx:(NSData *)data
//{
//    [self setLaucnImage:data];
//}


- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
    if ([operation isMemberOfClass:[GWGetAdvert class]]) {
        [self getLaunchImage:(NSString *)data];
    }
    if ([operation isMemberOfClass:[GWGetImage class]]) {
        [self setLaucnImage:data];
    }
}


- (void)getLaunchImage:(NSString *)url{
    NSDictionary *dictInfo = @{@"url":url};
    _operation = [[GWGetImage alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)setLaucnImage:(NSData *)data
{
//    NSString *fileName = [FxDate stringFromDateYMD:[NSDate date]];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image!=nil) {
        _imageView.image = image;
//        [data writeToFile:[FxGlobal getCacheImage:fileName] atomically:YES];
    }
}
@end
