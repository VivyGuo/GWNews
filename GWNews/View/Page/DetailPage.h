//
//  DetailPage.h
//  GWNews
//
//  Created by guowei on 16/1/2.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "GWBaseNavPage.h"
@class NewsInfo;
@interface DetailPage : GWBaseNavPage{
    IBOutlet UIWebView  *_webView;
}

@property(nonatomic, strong) NSString   *urlString;
@property(nonatomic, strong) NewsInfo   *newsInfo;

- (void)loadHtml;

@end
