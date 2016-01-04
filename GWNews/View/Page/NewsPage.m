
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
    //设置导航栏图标
    [self setNavTitleWithImage:@"NavigationBarIcon.png"];
    [self setNavLeftBarButtonItemWithImage:@"NavigationBell.png" selector:nil];
    [self setNavRightBarButtonItemWithImage:@"NavigationSquare.png" selector:@selector(showWeatherPage:)];
}

//添加栏目
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_columnBarWidget == nil) {
        [self addColumnBarWidget];
    }
}

- (void)addColumnBarWidget{
    _columnBarWidget = [[ColumnBarWidget alloc] init];
    
    _columnBarWidget.delegate = self;
    _columnBarWidget.view.frame = _columnBarView.bounds;
    [_columnBarView addSubview:_columnBarWidget.view];
    //将columnBarWidget返回视图层次的最后，便于显示阴影图片视图（此处没有）
//    [_columnBarView sendSubviewToBack:_columnBarWidget.view];
}
//选中某栏目后回调操作
- (void)didSelect:(NSInteger)coulumnIndex{
    
}





- (void)showWeatherPage:(id)sender{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
