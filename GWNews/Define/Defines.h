//
//  Defines.h
//  GWNews
//
//  Created by guowei on 15/12/8.
//  Copyright © 2015年 guowei. All rights reserved.
//

#if DEBUG
#define GWLog(format,...) NSLog(format,## __VA_ARGS__)
#else
#define GWLog(format,...)
#endif
//日志输出宏
#if DEBUG
#define BASE_LOG(cls,sel) GWLog(@"%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel))
#define BASE_INFO_LOG(cls,sel,info) GWLog(@"INFO:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),info)
#define BASE_ERROR_LOG(cls,sel,error) GWLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),error)
#else
#define BASE_LOG(cls,sel)
#define BASE_INFO_LOG(cls,sel,info)
#define BASE_ERROR_LOG(cls,sel,error)
#endif
//日志输出函数
#if DEBUG
#define BASE_LOG_FUN()          BASE_LOG([self class],_cmd)
#define BASE_INFO_FUN(info)     BASE_INFO_LOG([self class],_cmd,info)
#define BASE_ERROR_FUN(error)   BASE_ERROR_LOG([self class],_cmd,error)
#else
#define BASE_LOG_FUN()
#define BASE_INFO_FUN()
#define BASE_ERROR_FUN()
#endif

//判断设备类型
#define IsiPad          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain        ([[UIScreen mainScreen] scale] >= 2.0)

#define ScreenWidth      ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWith,ScreenHeight))
#define ScreenMinLength (MIN(ScreenWith,ScreenHeight))

#define IsiPhone4   (IsiPhone && ScreenMaxLength < 568.0)
#define IsiPhone5   (IsiPhone && ScreenMaxLenght == 568.0)
#define IsiPhone6   (IsiPhone && ScreenMaxLength == 667.0)
#define IsiPhone6s  (IsiPhone && ScreenMaxLength == 736.0)


// 文件缓存路径
#define RootPath            @"/Library/.GWNews"
#define CacheImagePath      @"CacheImages"
#define NewsIconPrex        @"GWNewsIcon_%@"
#define NewsDBFile          @"GWNews.db"

//广告常量
#define AdvertKey           @"AdvertKey"
#define AdvertCheckTime     60*60
#define AdvertDelayTime     3

// iOS系统版本
#define IOSBaseVersion8     8.0
#define IOSBaseVersion7     7.0
#define IOSBaseVersion6     6.0

// 其他常量
#define AnimationSecond     1.0
#define NavBarHeight        44
#define NavBarHeight7       64
#define LocationDistance    100




