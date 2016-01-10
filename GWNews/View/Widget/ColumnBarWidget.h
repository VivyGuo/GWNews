//
//  ColumnBarWidget.h
//  GWNews
//
//  Created by guowei on 16/1/5.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseWidget.h"
#import "GWButtonHelper.h"

@protocol ColumnBarDelegate ;
//ColumnBar包括横向滚动条和栏目按钮
@interface ColumnBarWidget : GWBaseViewController{
    IBOutlet UIScrollView  *_scrollView;
    GWButtonHelper         *_btnHelper;
}

@property(nonatomic,assign) NSInteger                columnIndex;
@property(nonatomic,weak)   id<ColumnBarDelegate>    delegate;
@property(nonatomic,strong) NSMutableArray           *listData;

@end

//栏目按钮单击事件
@protocol ColumnBarDelegate <NSObject>

- (void)didSelect:(NSInteger)coulumnIndex;

@end

