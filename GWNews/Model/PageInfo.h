//
//  PageInfo.h
//  GWNews
//
//  Created by guowei on 16/1/4.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "BaseInfo.h"
//TabBarController.viewControllers的子项数据源
//数据源从plist文件中获取
@interface PageInfo : BaseInfo

@property(nonatomic,copy) NSString      *image;
@property(nonatomic,copy) NSString      *selectImage;
@property(nonatomic,assign) BOOL        load;

+ (NSArray *)getPageViewControllerArray;
@end
