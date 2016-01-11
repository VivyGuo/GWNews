//
//  GWLandscapeTableView.m
//  GWNews
//
//  Created by guowei on 16/1/7.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWLandscapeTableView.h"
#import  "GWLandscapeCell.h"

@interface GWLandscapeTableView()<UIScrollViewDelegate>{
    
    // 存储页面的滚动条容器
    UIScrollView                *_scrollView;
    // 单元格之间的间隔
    CGFloat                     _gapBetweenCells;
    // 预先加载的单元格数，在可见单元格的两边预先加载不可见单元格的数目
    NSInteger                   _cellsToPreload;
    // 可重用单元格控件的集合
    NSMutableSet                *_recycledCells;
    // 当前可见单元格集合
    NSMutableSet                *_visibleCells;
    // 单元格总数
    NSInteger                   _cellCount;
    // 当前索引
//    NSInteger                   _currentCellIndex;
    // 上次选择的单元格索引
    NSInteger                   _lastCellIndex;
    // 加载当前可见单元格左边的索引
    NSInteger                   _firstLoadedCellIndex;
    // 加载当前可见单元格右边的索引
    NSInteger                   _lastLoadedCellIndex;
    // 页面容器是否正在滑动
    BOOL                        _scrollViewIsMoving;
    // 回收站是否可用，是否将不用的页控件保存到_recycledCells集合中
    BOOL                        _recyclingEnabled;
}
//界面配置
- (void)configureCellandScrollView;

//scrollView 事件相关
- (void)willBeginMoving;
- (void)didEndMoving;
@end

@implementation GWLandscapeTableView

#pragma mark - TableView init interface methods
//视图也可以从代码中加载，需要调用initWithFrame初始化数据
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        [self internalInit];
    }
    return self;
}
/*
 视图也可以从xib文件中加载，需要调用initWithCoder初始化数据
 UIView默认实现了<NSCoding>协议，可以将视图对象序列化(encodeWithCoder)到xib文件中
 UIView初始化时从xib文件中反序列化
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit
{
    _gapBetweenCells = 2.0f;
    _cellsToPreload = 1;
    _currentCellIndex = -1;
    _lastCellIndex = 0;
    _firstLoadedCellIndex = _lastLoadedCellIndex = -1;
    
    _recyclingEnabled = YES;
    _visibleCells = [[NSMutableSet alloc] init];
    _recycledCells = [[NSMutableSet alloc] init];
    
    //剪裁超出父视图范围的子视图部分
    self.clipsToBounds = YES;
    [self addScrollView];
}
- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:[self frameForScrollView]];
    //自动调整子控件与父控件中间的位置，宽高
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = YES;//滚动超过边界会反弹有反弹回来的效果
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
}
//scrollview的frame
- (CGRect)frameForScrollView
{
    CGSize size = self.bounds.size;//初始{320,444}
    CGRect frameRect = CGRectMake(-_gapBetweenCells/2, 0, size.width + _gapBetweenCells, size.height);
    return frameRect;
}

//在bounds改变时调用， 因此 UIScrollView 会在滚动时不停地调用layoutSubviews
// 通知系统需要更改布局 [self setNeedsLayout];
- (void)layoutSubviews
{
    CGRect oldFrame = _scrollView.frame;
    CGRect newFrame = [self frameForScrollView];
    
    if (!CGRectEqualToRect(oldFrame, newFrame)) {
        _scrollView.frame = newFrame;
    }
    if (oldFrame.size.height != _scrollView.frame.size.height) {
        BASE_INFO_FUN(@"layoutSubviews");
        [self configureCellandScrollView];
    }
}
//设置scrollview可滚动范围，回收单元格，设置可见单元格
- (void)configureCellandScrollView
{
    BASE_INFO_FUN(@"configureCellandScrollView");
    if (_scrollView.frame.size.width <= _gapBetweenCells + 1e-6)//1*10 ^ -6
        return;  // not our time yet
    if (_cellCount == 0 && _currentCellIndex > 0)
        return;  // still not our time
    
    //ScrollView可滚动范围
    CGSize contentSize = CGSizeMake(_scrollView.frame.size.width * _cellCount+2, _scrollView.frame.size.height);
    if (!CGSizeEqualToSize(_scrollView.contentSize, contentSize))
    {
        _scrollView.contentSize = contentSize;
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * _currentCellIndex, 0);
    }
    
    CGRect visibleBounds = _scrollView.bounds;
    NSInteger newCellIndex = MIN(MAX(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)), 0), _cellCount - 1);
    newCellIndex = MAX(0, MIN(_cellCount, newCellIndex));
    
    // calculate which pages are visible
    NSInteger firstVisibleCell = MAX(floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds)), 0);
    NSInteger lastVisibleCell  = MIN(floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds)), _cellCount - 1);
    NSInteger firstCell = MAX(0,            MIN(firstVisibleCell, newCellIndex - _cellsToPreload));
    NSInteger lastCell  = MIN(_cellCount-1, MAX(lastVisibleCell,  newCellIndex + _cellsToPreload));
    
    // recycle no longer visible cells
    NSMutableSet *cellsToRemove = [NSMutableSet set];
    for (GWLandscapeCell *cell in _visibleCells)
    {
        if (cell.tag < firstCell || cell.tag > lastCell) {
            [self recycleCell:cell];
            [cellsToRemove addObject:cell];
        }
    }
    [_visibleCells minusSet:cellsToRemove];
    
    // to avoid hiccups while scrolling, do not preload invisible pages temporarily
    BOOL quickMode = (_scrollViewIsMoving && _cellsToPreload > 0);
    // add missing cells
    NSLog(@"############firstCell%lu",(unsigned long)firstCell);
    NSLog(@"############lastCell%lu",(unsigned long)lastCell);

    for (NSInteger index = firstCell; index <= lastCell; index++)
    {
        if ([self cellForIndex:index] == nil) {
            // only preload visible pages in quick mode
            if (quickMode && (index < firstVisibleCell || index > lastVisibleCell))
                continue;
            
            GWLandscapeCell *cell = [_dataSource cellInTableView:self atIndex:index];
            [self configureCell:cell AtIndex:index];
            
            [_scrollView addSubview:cell];
            [_visibleCells addObject:cell];
        }
    }
    // update loaded cells info
    BOOL loadedCellsChanged = NO;
    if (!quickMode) {
        loadedCellsChanged = (_firstLoadedCellIndex != firstCell || _lastLoadedCellIndex != lastCell);
        if (loadedCellsChanged) {
            
            _firstLoadedCellIndex = firstCell;
            _lastLoadedCellIndex  = lastCell;
        }
    }
    
    // update current cell index
    BOOL cellIndexChanged = (newCellIndex != _currentCellIndex);
    if (cellIndexChanged) {
        _lastCellIndex = _currentCellIndex;
        _currentCellIndex = newCellIndex;
        
        if ([(NSObject *)_delegate respondsToSelector:@selector(tableView:didChangeAtIndex:)])
            [_delegate tableView:self didChangeAtIndex:_currentCellIndex];
    }
}
// 在可见单元格中获取指定索引的单元格
- (GWLandscapeCell *)cellForIndex:(NSUInteger)index
{
    NSLog(@"############cellForIndex%lu",(unsigned long)index);
    for (GWLandscapeCell *cell in _visibleCells) {
        
        if (cell.tag == index)
            return cell;
    }
    return nil;
}
//cell的frame,tag
- (void)configureCell:(GWLandscapeCell *)cell  AtIndex:(NSUInteger)index{
    cell.tag = index;
    
    CGFloat cellWidthWithGap = _scrollView.frame.size.width;
    CGSize cellSize = self.bounds.size;
    
    cell.frame = CGRectMake(cellWidthWithGap * index + _gapBetweenCells/2,0, cellSize.width, cellSize.height);
    //setNeedDisplay 标记一下，通知系统需要显示
    [cell setNeedsDisplay];
    
}

//回收单元格
- (void)recycleCell:(GWLandscapeCell *)cell
{
    if ([cell respondsToSelector:@selector(prepareForReuse)]) {
        [cell performSelector:@selector(prepareForReuse)];
    }
    if (_recyclingEnabled) {
        [_recycledCells addObject:cell];
    }
    [cell removeFromSuperview];
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
}

#pragma mark - Data and cell methods

- (void)setCurrentCellIndex:(NSInteger)newCellIndex
{
    if (_scrollView.frame.size.width > 0 && fabs(_scrollView.frame.origin.x - (-_gapBetweenCells/2)) < 1e-6) {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * newCellIndex, 0);
    }
    
    _currentCellIndex = newCellIndex;
    _lastCellIndex = _currentCellIndex;
}
//可重用单元格
- (GWLandscapeCell *)dequeueReusableCell
{
    GWLandscapeCell *result = [_recycledCells anyObject];
    
    if (result) {
        [_recycledCells removeObject:result];
    }
    
    return result;
}
//加载数据后，回收单元格，更新界面
- (void)reloadData
{
    _cellCount = [_dataSource numberOfCellsInTableView:self];
    
    // recycle all cells
    for (GWLandscapeCell *cell in _visibleCells) {
          [self recycleCell:cell];
    }
    
    [_visibleCells removeAllObjects];
    BASE_INFO_FUN(@"reloadData");
    [self configureCellandScrollView];
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollView == scrollView) {
        BASE_INFO_FUN(@"scrollViewDidScroll");
        [self configureCellandScrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_scrollView == scrollView) {
        [self willBeginMoving];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && _scrollView == scrollView) {
        
        [self didEndMoving];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView == scrollView) {
        [self didEndMoving];
    }
}

- (void)willBeginMoving
{
    if (!_scrollViewIsMoving) {
        
        _scrollViewIsMoving = YES;
        
        if ([(NSObject *)_delegate respondsToSelector:@selector(tableViewWillBeginMoving:)]) {
            
            [_delegate tableViewWillBeginMoving:self];
        }
    }
}

- (void)didEndMoving
{
    if (_scrollViewIsMoving)
    {
        _scrollViewIsMoving = NO;
        if (_cellsToPreload > 0){
            BASE_INFO_FUN(@"didEndMoving");
            [self configureCellandScrollView];
        }
        
        if ([(NSObject *)_delegate respondsToSelector:@selector(tableViewDidEndMoving:)]){
            [_delegate tableViewDidEndMoving:self];
        }
        
        if (_lastCellIndex != _currentCellIndex) {
            
            GWLandscapeCell *cell = [self cellForIndex:_lastCellIndex];
            cell.frame = cell.frame;
        }
    }
}


@end
