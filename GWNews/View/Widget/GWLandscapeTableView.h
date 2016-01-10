//
//  GWLandscapeTableView.h
//  GWNews
//
//  Created by guowei on 16/1/7.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWLandscapeCell;
@protocol GWLandscapeTableViewDataSource;
@protocol GWLandscapeTableViewDelegate;

@interface GWLandscapeTableView : UIView
//当前单元格索引
@property(nonatomic,assign) NSInteger  currentCellIndex;
// 返回可以重用的单元格控件,如果没有可重用的，返回nil
@property(nonatomic,strong) GWLandscapeCell *dequeueReusableCell;

@property(nonatomic,weak) IBOutlet id<GWLandscapeTableViewDataSource>    dataSource;
@property(nonatomic,weak) IBOutlet id<GWLandscapeTableViewDelegate>      delegate;

// 重新加载数据
- (void)reloadData;

@end

@protocol GWLandscapeTableViewDataSource
@required
- (NSInteger)numberOfCellsInTableView:(GWLandscapeTableView *)tableView;
- (GWLandscapeCell *)cellInTableView:(GWLandscapeTableView *)tableView atIndex:(NSInteger)index;

@end

@protocol GWLandscapeTableViewDelegate
@optional
- (void)tableView:(GWLandscapeTableView *)tableView didChangeAtIndex:(NSInteger)index;
- (void)tableView:(GWLandscapeTableView *)tableView didSelectCellAtIndex:(NSInteger)index;

- (void)tableViewWillBeginMoving:(GWLandscapeTableView *)tableView;
- (void)tableViewDidEndMoving:(GWLandscapeTableView *)tableView;

@end