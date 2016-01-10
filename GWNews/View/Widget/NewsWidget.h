//
//  NewsTableView.h
//  GWNews
//
//  Created by guowei on 16/1/8.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseViewController.h"
@class ColumnInfo;
@interface NewsWidget : GWBaseViewController

@property(nonatomic,weak) IBOutlet UITableView    *newsTableView;
@property(nonatomic,strong)NSString               *cellIdentifier;
@property(nonatomic,assign)CGFloat                cellHeight;

@property(nonatomic,strong)NSMutableArray         *listData;
@property(nonatomic,copy)NSString                 *newsUrl;
@property(nonatomic,assign)id                     owner;

@property(nonatomic,assign)NSInteger              pageIndex;
@property(nonatomic,assign)BOOL                   hasNextPage;

- (void)reloadData;
@end
