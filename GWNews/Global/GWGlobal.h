//  Created by hejinbo on 15/5/12.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GWPush.h"

@interface GWGlobal : NSObject

//@property(nonatomic, strong) GWPush     *push;

+ (GWGlobal *)global;

// 系统版本
+ (BOOL)isSystemLowIOS8;
+ (BOOL)isSystemLowIOS7;
+ (BOOL)isSystemLowiOS6;
+ (NSString *)clientVersion;

// 缓存路径
+ (NSString *)getRootPath;
+ (NSString *)getCacheImage:(NSString *)fileName;
+ (NSString *)getUserDBFile;
+ (BOOL)setNotBackUp:(NSString *)filePath;

// 系统提示
+ (void)alertMessage:(NSString *)message;
+ (void)alertMessageEx:(NSString *)message
                 title:(NSString *)title
              okTtitle:(NSString *)okTitle
           cancelTitle:(NSString *)cancelTitle
              delegate:(id)delegate;

// 退出
+ (void)logout;

@end
