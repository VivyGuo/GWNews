
//
//  NewsPage.m
//  GWNews
//
//  Created by guowei on 16/1/2.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "NewsPage.h"
#import "GWLandscapeTableView.h"
#import "GWLandscapeCell.h"
#import "NewsInfo.h"
#import "ColumnInfo.h"

@interface NewsPage ()

@end

@implementation NewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏图标
    [self setNavTitleWithImage:@"NavigationBarIcon.png"];
    [self setNavLeftBarButtonItemWithImage:@"NavigationBell.png" selector:nil];
    [self setNavRightBarButtonItemWithImage:@"NavigationSquare.png" selector:nil];
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
    //将columnBarWidget返回视图层次的最后，便于显示阴影图片视图
    [_columnBarView sendSubviewToBack:_columnBarWidget.view];
}
//选中某栏目后回调操作
- (void)didSelect:(NSInteger)columnIndex{
    NSLog(@"#############columnIndex%ld",(long)columnIndex);
    if (_landscapeTableView.currentCellIndex != columnIndex) {
        _landscapeTableView.currentCellIndex = columnIndex;
        [_landscapeTableView reloadData];
    }
}
//添加landscapTableView
#pragma mark - FxLandscapeViewDataSource & FxLandscapeViewDelegate methods

- (NSInteger)numberOfCellsInTableView:(GWLandscapeTableView *)tableView
{
    return _columnBarWidget.listData.count;
}

- (GWLandscapeCell *)cellInTableView:(GWLandscapeTableView *)tableView atIndex:(NSInteger)index
{
    
    GWLandscapeCell *cell = (GWLandscapeCell *)[tableView dequeueReusableCell];
    if (cell == nil) {
        cell = [[GWLandscapeCell alloc] initWithFrame:_landscapeTableView.bounds];
        cell.owner = self;
    }
    //GWLandscapeCell包含一个竖向NewsTableView,根据栏目id添加相应的NewsTableView
    ColumnInfo *info = [_columnBarWidget.listData objectAtIndex:index];
    //NewsWidget根据栏目的urlString加载网络数据
    //NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/0-20.html",columnInfo.urlString
    [cell setCellData:info.urlString];
    
    return cell;
}

- (void)tableView:(GWLandscapeTableView *)tableView didChangeAtIndex:(NSInteger)index
{
    _columnBarWidget.columnIndex = index;
}


@end
