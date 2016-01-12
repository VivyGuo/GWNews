//
//  DetailPage.m
//  GWNews
//
//  Created by guowei on 16/1/2.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "DetailPage.h"
#import "DetailInfo.h"
#import "GWGetDetail.h"
#import "NewsInfo.h"

@implementation DetailPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barBackgroudImage = @"NavigationBarWhite";
    [self loadHtml];
    
}
- (void)dealloc
{
    [_webView stopLoading];
    _webView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavLeftBarButtonItemWithImage:@"NavigationBackBlack.png" selector:@selector(doBack:)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)loadHtml
{
    [self showIndicator:LoadingTip autoHide:NO afterDelay:NO];
    
    [self showIndicator:LoadingTip autoHide:NO afterDelay:NO];
    [self executeDetailOperation];
}

- (void)executeDetailOperation
{
    //NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",columnInfo.urlString
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",_newsInfo.ID];
    NSDictionary *dictInfo = @{@"url":url,@"docid":_newsInfo.ID};
    
    _operation = [[GWGetDetail alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)operation:(GWNetworkOperation *)operation successWithData:(DetailInfo *)info
{
    _operation = nil;
    
    NSString *urlString = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
    NSString *htmlString = [self htmlConvert:info];
    
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:urlString]];
}

- (NSString *)htmlConvert:(DetailInfo *)info
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
    NSString *html = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];

//    NSLog(@"###info%@",info);
    html = [html stringByReplacingOccurrencesOfString:HtmlBody withString:info.body];
    html = [html stringByReplacingOccurrencesOfString:HtmlTitle withString:info.title];
    html = [html stringByReplacingOccurrencesOfString:HtmlSource withString:info.source];
    html = [html stringByReplacingOccurrencesOfString:HtmlPTime withString:info.ptime];
    html = [html stringByReplacingOccurrencesOfString:HtmlDigest withString:info.digest];
    html = [html stringByReplacingOccurrencesOfString:HtmlEC withString:info.ec];

////    if (info.images.count > 0) {
////        NSString *img = nil;
////        
////        for (ContentImageInfo *imageInfo in info.images) {
////            img = [NSString stringWithFormat:HtmlImage, imageInfo.src];
////            html = [html stringByReplacingOccurrencesOfString:imageInfo.ref withString:img];
////        }
////    }
//    
    return html;
}
- (IBAction)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideIndicator];
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest*)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
@end

