//
//  ZYInterceptorWithNetwork.m
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYInterceptorWithNetwork.h"
#import <UIKit/UIKit.h>

@implementation ZYInterceptorWithNetwork
#pragma mark -- netWorkConnection

+ (BOOL)isConnectionAvailableWithStatus:(ZYNetworkStatusBlock)networkStatusBlock {
    BOOL  isConnection = YES;
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isConnection = NO;
            if (networkStatusBlock != nil) {
                networkStatusBlock(NotReachable);
            }
            break;
        case ReachableViaWiFi:
            isConnection = YES;
            if (networkStatusBlock != nil) {
                networkStatusBlock(ReachableViaWiFi);
            }
            break;
        case ReachableViaWWAN:
            isConnection = YES;
            if (networkStatusBlock != nil) {
                networkStatusBlock(ReachableViaWWAN);
            }
            break;
            
    }
    if (!isConnection) {
        return NO;
    }
    return isConnection;
}

#pragma mark -- 拦截器相关
- (void)loadInterceptorWithActionName:(NSString *)actionName optionType:(AspectOptions) optionType error:(ZYInterceptorErrorBlock)errorBlock {
    if ([actionName containsString:@":"]) {
        NSError *error = nil;
        
        [UIViewController aspect_hookSelector:NSSelectorFromString(actionName) withOptions:optionType usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            UIViewController * vc = [aspectInfo instance];
            if ([vc isKindOfClass:NSClassFromString(@"UIInputWindowController")] || [vc isKindOfClass:NSClassFromString(@"UIAlertController")] || [vc isKindOfClass:NSClassFromString(@"UIInputViewController")] || [vc isKindOfClass:NSClassFromString(@"UIRemoteInputViewController")] || [vc isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")]) {
                return ;
            }
            if (!vc.isDisabledInterceptor) {
                [self action:animated viewController:vc];
            }
        } error:&error];
    }else {
        NSAssert(NO, @"没有包含:");
    }
}
// 单例


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZYInterceptorWithNetwork *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZYInterceptorWithNetwork alloc] init];
    });
    return sharedInstance;
}
// 通过这种方式可以代替原来框架中的基类，不必每个 ViewController 再去继续原框架的基类
#pragma mark - alternative methods
- (void)action:(BOOL)animated viewController:(UIViewController *)viewController
{
    if (!viewController.isInitTheme) {
        // 去做基础业务相关的内容
        viewController.isInitTheme = YES;
    }
    if (![ZYInterceptorWithNetwork isConnectionAvailableWithStatus:nil]) {
        //设置提示框或者什么操作
        UIViewController *currentVc = [self getCurrentController];
        if (self.promptStr.length != 0 && self.title.length != 0 && self.btnText.length != 0 ) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:_title message:_promptStr preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:_btnText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVc addAction:sureBtn];
            [currentVc presentViewController:alertVc animated:YES completion:nil];
        }else {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络状况不太好，请检查网络..." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVc addAction:sureBtn];
            [currentVc presentViewController:alertVc animated:YES completion:nil];
        }
    }
}

#pragma mark - 获取当前控制器
-(UIViewController *)getCurrentController{
    UIViewController *reController = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel!= UIWindowLevelNormal) {
        NSArray *array = [[UIApplication sharedApplication]windows];
        for (UIWindow *win in array) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    UIView *cuView = [[window subviews]objectAtIndex:0];
    id responder = [cuView nextResponder];
    if ([responder isKindOfClass:[UIViewController class]]) {
        reController = responder;
    }
    else{
        reController = window.rootViewController;
    }
    return reController;
}
@end
