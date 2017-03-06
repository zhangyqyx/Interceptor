//
//  ZYInterceptorWithNetwork.h
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Aspects.h"
#import "UIViewController+ZYIimit.h"

/**
 NetworkStatus 三种状态
  1、  NotReachable = 没有网络,
  2、  ReachableViaWiFi = wifi,
  3、  ReachableViaWWAN = 数据连接
*/
typedef void(^ZYNetworkStatusBlock)(NetworkStatus networkStatus);
typedef void(^ZYInterceptorErrorBlock)(NSError *interceptorError);

@interface ZYInterceptorWithNetwork : NSObject
/**提示框内容 */
@property (nonatomic , strong)NSString *promptStr;
/**提示框标题 */
@property (nonatomic , strong)NSString *title;
/** 按钮文字 */
@property (nonatomic , strong)NSString *btnText;


/**
 检测是否有网络连接
 
 @param networkStatusBlock  三种网络状态
 @return 是否连接网络
 */
+ (BOOL)isConnectionAvailableWithStatus:(ZYNetworkStatusBlock)networkStatusBlock;
/**
 加载拦截器的方法
 
 @param actionName  监听的方法的字符串  如（viewDidAppear:)记住一定要加 ：
 @param optionType  执行方法的类型
 AspectPositionAfter   = 0,   在原本方法后执行 (default)
 AspectPositionInstead = 1,    替换原本方法
 AspectPositionBefore          在原本方法前执行
 @param errorBlock 拦截错误信息
 */
- (void)loadInterceptorWithActionName:(NSString *)actionName optionType:(AspectOptions) optionType error:(ZYInterceptorErrorBlock)errorBlock;
/**
 单例
 @return self
 */
+ (instancetype)sharedInstance;



@end
