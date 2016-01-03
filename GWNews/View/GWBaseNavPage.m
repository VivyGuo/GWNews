//
//  GWBaseNavPage.m
//  GWNews
//
//  Created by guowei on 16/1/3.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseNavPage.h"

@interface GWBaseNavPage ()

@end

@implementation GWBaseNavPage

- (void)viewDidLoad {
    self.barBackgroudImage = @"NavigationBarRed";
    [super viewDidLoad];
}
/*显示状态栏(电池和信号部分),设置状态栏内容为白色，默认黑色
 设置导航栏样式
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self setNavigationBackground];
}
//设置导航栏navigationBar 背景图片、颜色、Title字体
- (void)setNavigationBackground
{
    NSString *imageName = [self.barBackgroudImage stringByAppendingFormat:@"%d.png", [GWGlobal isSystemLowIOS7]?NavBarHeight:NavBarHeight7];
    UIImage *image = [UIImage imageNamed:imageName];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]
                                };
    
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//设置导航栏navigationItem 按钮文字样式
- (void)setNavBarButtonItemWithTitle:(NSString *)title selector:(SEL)selector isRight:(BOOL)isRight
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    item.tintColor = [UIColor blackColor];

    if (isRight)
        self.navigationItem.rightBarButtonItem = item;
    else
        self.navigationItem.leftBarButtonItem = item;
}
//设置导航栏navigationItem Title图片样式
- (void)setNavTitleWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}
//设置导航栏navigationItem 左按钮图片样式
- (void)setNavLeftBarButtonItemWithImage:(NSString *)imageName selector:(SEL)selector
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName selector:selector]];
    self.navigationItem.leftBarButtonItem = item;
}
//设置导航栏navigationItem 右按钮图片样式
- (void)setNavRightBarButtonItemWithImage:(NSString *)imageName selector:(SEL)selector
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName selector:selector]];
    self.navigationItem.rightBarButtonItem = item;
}
//设置自定义Button，避免在iOS7以前白色背景问题
- (UIButton *)customButton:(NSString *)imageName selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
//导航栏返回
- (IBAction)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
