//
//  GWBaseNavPage.h
//  GWNews
//
//  Created by guowei on 16/1/3.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseViewController.h"
/*
 NavigationController -> NavigationBar -> NavigationItem
 Title ,NavigationLeftBarButtomItem,NavigationRightBarButtomItem
设置导航栏Title图片样式,设置导航栏按钮图片样式/文字样式,返回事件
 */
@interface GWBaseNavPage : GWBaseViewController

@property(nonatomic, copy) NSString   *barBackgroudImage;

- (void)setNavTitleWithImage:(NSString *)imageName;
- (void)setNavLeftBarButtonItemWithImage:(NSString *)imageName selector:(SEL)selector;
- (void)setNavRightBarButtonItemWithImage:(NSString *)imageName selector:(SEL)selector;
- (void)setNavBarButtonItemWithTitle:(NSString *)title selector:(SEL)selector isRight:(BOOL)isRight;

- (IBAction)doBack:(id)sender;

@end
