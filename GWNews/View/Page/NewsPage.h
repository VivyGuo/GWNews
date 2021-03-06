//
//  NewsPage.h
//  GWNews
//
//  Created by guowei on 16/1/2.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseNavPage.h"
#import "ColumnBarWidget.h"
@class ColumnBarWidget;
@class  GWLandscapeTableView;
@interface NewsPage : GWBaseNavPage<ColumnBarDelegate>{
    IBOutlet UIView         *_columnBarView;
    ColumnBarWidget         *_columnBarWidget;
    IBOutlet GWLandscapeTableView    *_landscapeTableView;
}

@end
