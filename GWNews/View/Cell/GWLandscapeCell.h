//
//  GWLandscapeCell.h
//  GWNews
//
//  Created by guowei on 16/1/7.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsWidget;
@class ColumnInfo;

@interface GWLandscapeCell : UIView

@property(nonatomic,strong) NewsWidget     *newsWidget;
@property(nonatomic,assign) id              owner;

- (void)setCellData:(NSString *)url;

@end
