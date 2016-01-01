//
//  GwOperation.h
//  GWNews
//
//  Created by guowei on 15/12/21.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GWNetworkOperationDelegate;
/*
 网络操作基类：发送网络请求操作，获取数据
 */
@interface GWNetworkOperation : NSObject{
    __weak id<GWNetworkOperationDelegate> _delegate;
    NSDictionary        *_opInfo;
}

- (instancetype)initWithDelegate:(id<GWNetworkOperationDelegate>)delegate
                opInfo:(NSDictionary *)opInfo;
- (void)executeOp;
- (void)cancelOp;
- (void)parseSuccessData:(NSData *)data;
- (void)parseFailData:(NSString *)error;

@end

/*
 网络请求代理:定义获取请求后操作
 */
@protocol GWNetworkOperationDelegate <NSObject>
//- (void)opSuccess:(id)data;
//- (void)opFail:(NSString *)errorMessage;

- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data;
- (void)operation:(GWNetworkOperation *)operation failWithErrorMessage:(NSString *)message;

@optional
- (void)opSuccessEx:(id)data;
- (void)opFailEx:(NSString *)errorMessage;

@end
