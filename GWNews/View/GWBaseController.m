//
//  GWBaseController.m
//  GWNews
//
//  Created by guowei on 15/12/31.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWBaseController.h"
#import "GWActivityIndicator.h"

@interface GWBaseController (){
    GWActivity      *_activity;
}
@end

@implementation GWBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [_operation cancelOp];
    _operation = nil;
}
#pragma mark - GWNetworkOperationDelegate methods
//- (void)opSuccess:(id)data{
//    [self hideIndicator];
//}
//- (void)opFail:(NSString *)errorMessage{
//    BASE_ERROR_FUN(errorMessage);
//    [self showIndicator:@"请求错误" autoHide:YES afterDelay:YES];
//}

- (void)operation:(GWNetworkOperation *)operation successWithData:(id)data{
    [self hideIndicator];
}

- (void)operation:(GWNetworkOperation *)operation failWithErrorMessage:(NSString *)message{
    BASE_ERROR_FUN(message);
    [self showIndicator:@"请求错误" autoHide:YES afterDelay:YES];
}



#pragma mark - Activity methods
/*显示、隐藏提示框*/
- (void)showIndicator:(NSString *)tipMessage
             autoHide:(BOOL)hide
           afterDelay:(BOOL)delay
{
    if (_activity == nil) {
        _activity = [self showActivityInView:self.view];
    }
    
    if (tipMessage != nil) {
        _activity.labelText = tipMessage;
        [_activity show:NO];
    }
    
    if (hide && _activity.alpha>=1.0) {
        if (delay)
            [_activity hide:YES afterDelay:AnimationSecond];
        else
            [_activity hide:YES];
    }
}

- (void)hideIndicator
{
    [_activity hide:YES];
}
- (GWActivity *)showActivityInView:(UIView *)view
{
    GWActivity *activity = [[GWActivityIndicator alloc] initWithView:view];
    CGRect frame = view.bounds;
    
    activity.frame = frame;
    [view addSubview:activity];
    activity.labelText = @"";
    
    return activity;
}


@end
