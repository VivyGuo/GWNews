//
//  GWLandscapeCell.m
//  GWNews
//
//  Created by guowei on 16/1/7.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWLandscapeCell.h"
#import "NewsWidget.h"
@implementation GWLandscapeCell

/*初始化NewsWidget(包含竖向tableView)，将columnInfo.urlString传入NewsWidget*/

- (void)setCellData:(NSString *)url{
    
    if (_newsWidget == nil) {
        _newsWidget = [[NewsWidget alloc] init];
        _newsWidget.newsUrl = url;
        _newsWidget.owner = self.owner;//newsWidget.owner = NewsPage
        _newsWidget.view.frame = self.bounds;
        
        [self addSubview:_newsWidget.view];
    }
    else {
        _newsWidget.newsUrl = url;
        [_newsWidget reloadData];
    }
}

@end
