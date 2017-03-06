//
//  UIViewController+Iimit.h
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZYIimit)
/** 拦截器是否有效*/
@property(nonatomic, assign) BOOL isDisabledInterceptor;
/** 初始化后是否会再次执行  */
@property(nonatomic, assign) BOOL isInitTheme;
@end
