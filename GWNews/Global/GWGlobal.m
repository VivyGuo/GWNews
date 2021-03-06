//  Created by hejinbo on 15/5/12.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import "GWGlobal.h"
//#import "MiPush.h"

@implementation GWGlobal

+ (GWGlobal *)global
{
    static GWGlobal *s_global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_global = [[GWGlobal alloc] init];
    });
    
    return s_global;
}

- (id)init
{
    self = [super init];
    if (self) {
//        self.push = [[MiPush alloc] init];
    }
    
    return self;
}


#pragma mark - 系统版本

+ (BOOL)isSystemLowIOS8
{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion8 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowIOS7
{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion7 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowiOS6
{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer < IOSBaseVersion6) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)clientVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}


#pragma mark - 缓存路径

+ (NSString *)getRootPath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:RootPath];
//    BASE_INFO_FUN(NSHomeDirectory());//沙盒目录
    return path;
}

+ (NSString *)getCacheImage:(NSString *)fileName
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", [GWGlobal getRootPath], CacheImagePath];
    [GWFileUtility createPath:path];//创建目录
    path = [NSString stringWithFormat:@"%@/%@.jpg", path, fileName];
    
    return path;
}

+ (NSString *)getUserDBFile
{
    NSString *path = [GWGlobal getRootPath];
    
    return [path stringByAppendingPathComponent:NewsDBFile];
}

+ (BOOL)setNotBackUp:(NSString *)filePath
{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSNumber *attrValue = [NSNumber numberWithBool:YES];
    
    [fileURL setResourceValue:attrValue
                       forKey:NSURLIsExcludedFromBackupKey
                        error:&error];
    if (error!=nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    
    return YES;
}


#pragma mark - 系统提示

+ (void)alertMessage:(NSString *)message
{
    [GWGlobal alertMessageEx:message
                       title:nil
                    okTtitle:@"确定"
                 cancelTitle:nil
                    delegate:nil];
}

+ (void)alertMessageEx:(NSString *)message
                 title:(NSString *)title
              okTtitle:(NSString *)okTitle
           cancelTitle:(NSString *)cancelTitle
              delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:delegate
                              cancelButtonTitle:cancelTitle
                              otherButtonTitles:okTitle,
                              nil];
    
    [alertView show];
}

+ (void)logout
{
}

@end
