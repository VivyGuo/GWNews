//
//  GWBaseController.h
//  GWNews
//
//  Created by guowei on 15/12/31.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWNetworkOperation.h"
/*
 视图基类：
 URL请求后处理回调操作;
 显示/隐藏提示框;
 */
@interface GWBaseController : UIViewController<GWNetworkOperationDelegate>{
    GWNetworkOperation      *_operation;
}
- (void)showIndicator:(NSString *)tipMessage
             autoHide:(BOOL)hide afterDelay:(BOOL)delay;
- (void)hideIndicator;


@end
