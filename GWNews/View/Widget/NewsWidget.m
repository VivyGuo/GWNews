//
//  NewsTableView.m
//  GWNews
//
//  Created by guowei on 16/1/8.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "NewsWidget.h"
#import "GWGetNews.h"
#import "NewsInfo.h"
#import "NewsTableViewCell.h"
#import "DetailPage.h"

@interface NewsWidget ()

@end

@implementation NewsWidget

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellIdentifier = @"NewsTableViewCell";
    self.cellHeight = 80;
//    self.pageIndex = 0;
    self.hasNextPage = NO;
    self.listData = [[NSMutableArray alloc] init];
    
    [self requestNewsOperation];
//    [self.newsTableView reloadData];

}

- (void)reloadData{
    BASE_INFO_FUN(@"reloadData");
    // 停止网络请求
    [_operation cancelOp];
    _operation = nil;
//    self.pageIndex = 0;
    // 清除上次内容
    [self.listData removeAllObjects];
    
    [self requestNewsOperation];
//    [self.newsTableView reloadData];
    
}

- (void)requestNewsOperation
{   
    //http://c.m.163.com/nc/article/list/T1351233117091/0-20.html
    NSString *url = [NSString stringWithFormat:NewsURL,self.newsUrl];
    NSDictionary *dictInfo = @{@"url":url};
    
    _operation = [[GWGetNews alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];

}

- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
    _operation = nil;
    self.hasNextPage = YES;
    
//    if (self.pageIndex == 0) {
//        [self.listData removeAllObjects];
//    }
//    self.pageIndex++;
    
    [self.listData addObjectsFromArray:data];//NewsInfo Array
    [self.newsTableView reloadData];
    [self hideIndicator];
}

-(void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
//    return indexPath.row < self.listData.count ? self.cellHeight:44;//分页行高为44
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
//    return self.hasNextPage?self.listData.count+1:self.listData.count;//分页多一个“正在加载”cell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = self.cellIdentifier;
    NewsInfo *info = [self.listData objectAtIndex:indexPath.row];
    NewsTableViewCell *cell = (NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    [cell setCellData:info];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailPage *page = [[DetailPage alloc] init];
    
    page.newsInfo = [self.listData objectAtIndex:indexPath.row];
    page.hidesBottomBarWhenPushed = YES;//隐藏导航bar
    
    UIViewController *owner =  self.owner;
    [owner.navigationController pushViewController:page animated:YES];
}
@end
