//
//  GwOperation.m
//  GWNews
//
//  Created by guowei on 15/12/21.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWNetworkOperation.h"
//class category 隐藏不需要对外公开的实例变量
//定义实例变量而不是属性，实例变量无需为其生成set get 方法，也不使用键值监测(KVO)
@interface GWNetworkOperation(){
    NSURLConnection     *_connection;
    NSMutableData       *_receiveData;
    NSInteger           _statusCode;
}
- (NSMutableURLRequest *)urlRequest;
@end

@implementation GWNetworkOperation

- (instancetype)initWithDelegate:(id<GWNetworkOperationDelegate>)delegate opInfo:(NSDictionary *)opInfo{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _opInfo = opInfo;
    }
    return  self;
}

- (void)dealloc{
    if (_connection != nil) {
        BASE_INFO_FUN(@"connection and delegate dealloc");
        [_connection cancel];
    }
    _connection = nil;
    _delegate = nil;
}

/*
 根据opInfo中URL创建NSURLRequst，设置超时时间，默认GET请求
 若opInfo中body不为空，设置Requst为POST请求
 */
- (NSMutableURLRequest *)urlRequest{
    NSString *urlString = [_opInfo objectForKey:@"url"];
    id body = [_opInfo objectForKey:@"body"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    BASE_INFO_FUN(urlString);
    
    if (body != nil) {
        [request setHTTPMethod:@"POST"];
        if ([body isKindOfClass:[NSString class]]) {
            [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            [request setHTTPBody:body];
        }
    }else{
        [request setHTTPMethod:@"GET"];
    }
    [request setTimeoutInterval:(NSTimeInterval)GWRequestTimeout];
    return request;
}
//发起url请求
- (void)executeOp{
    _connection = [[NSURLConnection alloc] initWithRequest:[self urlRequest] delegate:self];
}
//取消url请求
- (void)cancelOp{
    if (_connection != nil) {
        BASE_INFO_FUN(@"connection cancelOp");
        [_connection cancel];
    }
    _connection = nil;
}
//实现代理(delegate)的类完成具体操作
- (void)parseSuccessData:(NSData *)data{
//    [_delegate opSuccess:data];
    [_delegate operation:self successWithData:data];
}

- (void)parseFailData:(NSString *)error{
//    [_delegate opFail:error];
    [_delegate operation:self failWithErrorMessage:error];
}

#pragma mark - NSURLConnectionDataDelegate methods
//发送请求，收到响应后，初始化receiveData;获取状态码
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSString *statusCode = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
    
        _statusCode = [statusCode intValue];
        _receiveData = [[NSMutableData alloc] init];
    
        BASE_INFO_FUN(([NSString stringWithFormat:@"statusCode:%@",statusCode]));
}

//发送请求，收到数据后，赋值receiveData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        BASE_INFO_FUN(([NSString stringWithFormat:@"Data length:%lu", (unsigned long)data.length]));
//        BASE_INFO_FUN(([NSString stringWithFormat:@"ScreenHeight:%f",ScreenHeight]));
//        BASE_INFO_FUN(([NSString stringWithFormat:@"ScreenWidth:%f",ScreenWidth]));
    
        [_receiveData appendData:data];
}

//请求结束，处理数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *receiveDataStr = [[NSString alloc] initWithData:_receiveData encoding:NSUTF8StringEncoding];
//    BASE_INFO_FUN(receiveDataStr);
    
    // 成功接受：200有数据，204没有数据，206断点续传
    if (_statusCode == 200 || _statusCode == 204 || _statusCode == 206) {
        [self parseSuccessData:_receiveData];
    }else {
        if (_receiveData.length <= 0) {
            receiveDataStr = [[NSString alloc] initWithFormat:@"ResponseCode:%ld", (long)_statusCode];
        }
        
        [self parseFailData:receiveDataStr];
    }
    _connection = nil;
    _receiveData = nil;
}
//请求失败处理
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self parseFailData:[error localizedDescription]];
    _connection = nil;
    _receiveData = nil;
}
@end
