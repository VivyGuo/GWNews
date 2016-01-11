//
//  ColumnBarWidget.m
//  GWNews
//
//  Created by guowei on 16/1/5.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "ColumnBarWidget.h"
#import "ColumnInfo.h"

@implementation ColumnBarWidget

//加载栏目按钮
- (void)viewDidLoad
{
    [super viewDidLoad];
    _btnHelper = [[GWButtonHelper alloc]init];
    self.listData = [ColumnInfo getColumnInfos];
    [self updateUI];
}

- (void)updateUI
{
    [self addColumnBar];
    self.columnIndex = 0;
}
//自定义栏目按钮，将按钮加入ScrollView
- (void)addColumnBar
{
    // 先删除再添加
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger index = 0;
    CGFloat origin_x = 0;
    CGFloat insets = 18.0f;//18.0f
    UIEdgeInsets buttonInsets = UIEdgeInsetsMake(0.0f, insets, 0.0f, insets);
    CGSize titleSize = CGSizeZero;
    UIButton *button = nil;
    ColumnInfo *info = nil;
    
    _scrollView.contentInset = buttonInsets;
    
    for(index=0; index<self.listData.count; index++) {
        
        info = [self.listData objectAtIndex:index];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index+1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:info.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        titleSize = [info.name sizeWithFont:button.titleLabel.font];
        button.frame = CGRectMake(origin_x, 0.0f, titleSize.width+20.0f, 36);//+20.0f
        origin_x += titleSize.width + 3.0f + 20.0f;
        
        [_scrollView addSubview:button];
    }
    
    _scrollView.contentSize = CGSizeMake(origin_x, 36);
}
//栏目更改时，newsTableView也随之变化
- (void)setColumnIndex:(NSInteger)columnIndex
{
    _columnIndex = columnIndex;
    
    UIButton *sender = ((UIButton *)[_scrollView.subviews objectAtIndex:columnIndex]);
    [self buttonClicked:sender];
}

//单击按钮，设置选中态样式，回调传值(按钮索引)
- (void)buttonClicked:(UIButton *)sender
{
    _columnIndex = sender.tag -1;
//    NSLog(@"###########buttonCilicked:%ld",(long)_columnIndex);
    
    [self setColumnTabCenter:sender.frame];
    [_btnHelper setButton:sender normalColor:[UIColor blackColor] selectedColor:[UIColor redColor]];
    
    [self.delegate didSelect:_columnIndex];
}

//点击按钮，按钮居中设置
- (void)setColumnTabCenter:(CGRect)frame {
    
    CGFloat xOffer = frame.origin.x - _scrollView.contentOffset.x - 320/2;//320/2
    xOffer = _scrollView.contentOffset.x+xOffer+frame.size.width/2;
    
    if (xOffer < 18)
        xOffer = -18;
    else if (xOffer + 320 > _scrollView.contentSize.width)
        xOffer = _scrollView.contentSize.width - 320+18;
    
    if (xOffer <= 0)
        xOffer = -18;
    
    [_scrollView setContentOffset:CGPointMake(xOffer, 0) animated:YES];
}

@end
