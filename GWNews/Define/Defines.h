//
//  Defines.h
//  GWNews
//
//  Created by guowei on 15/12/8.
//  Copyright © 2015年 guowei. All rights reserved.
//

#if DEBUG
#define GwLog(format,...) NSLog(format,##__VA_ARGS__)
#else
#define GwLog(format,...)
#endif
//日志输出宏
#if DEBUG
#define BASE_LOG(cls,sel) GwLog(@"%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel))
#define BASE_INFO_LOG(cls,sel,info) GwLog(@"INFO:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),info)
#define BASE_ERROR_LOG(cls,sel,error) GwLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),error)
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

#define ScreenWith      ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWith,ScreenHeight))
#define ScreenMinLength (MIN(ScreenWith,ScreenHeight))

#define IsiPhone4   (IsiPhone && ScreenMaxLength < 568.0)
#define IsiPhone5   (IsiPhone && ScreenMaxLenght == 568.0)
#define IsiPhone6   (IsiPhone && ScreenMaxLength == 667.0)
#define IsiPhone6s  (IsiPhone && ScreenMaxLength == 736.0)





