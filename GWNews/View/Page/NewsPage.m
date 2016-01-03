
//
//  NewsPage.m
//  GWNews
//
//  Created by guowei on 16/1/2.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "NewsPage.h"

@interface NewsPage ()

@end

@implementation NewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleWithImage:@"NavigationBarIcon.png"];
    [self setNavLeftBarButtonItemWithImage:@"NavigationBell.png" selector:nil];
    [self setNavRightBarButtonItemWithImage:@"NavigationSquare.png" selector:@selector(showWeatherPage:)];
}

- (void)showWeatherPage:(id)sender{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
