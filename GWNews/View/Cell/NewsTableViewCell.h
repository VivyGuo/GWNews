//
//  NewsTableViewCell.h
//  GWNews
//
//  Created by guowei on 16/1/8.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsInfo;
@interface NewsTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView    *imageIcon;
@property(nonatomic,weak) IBOutlet UILabel        *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel        *descLabel;

@property(nonatomic, strong) NewsInfo             *cellInfo;

- (void)initCell;
- (void)setCellData:(NewsInfo *)info;
@end
