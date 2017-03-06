//
//  UIViewController+Iimit.m
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIViewController+ZYIimit.h"
#import <objc/runtime.h>
#import "Aspects.h"

#define KeyIsInitTheme @"KeyIsInitTheme"
#define KeyDisabledInterceptor @"KeyDisabledInterceptor"

@implementation UIViewController (ZYIimit)

#pragma mark - private property
- (BOOL)isInitTheme {
    return objc_getAssociatedObject(self, KeyIsInitTheme);
}

- (void)setIsInitTheme:(BOOL)isInitTheme {
    objc_setAssociatedObject(self, KeyIsInitTheme, @(isInitTheme), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isDisabledInterceptor {
     return objc_getAssociatedObject(self, KeyDisabledInterceptor);
}
- (void)setIsDisabledInterceptor:(BOOL)isDisabledInterceptor {
    NSNumber *integer = @(isDisabledInterceptor);
    if (integer.intValue == 0) {
        objc_setAssociatedObject(self, KeyDisabledInterceptor, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        objc_setAssociatedObject(self, KeyDisabledInterceptor, integer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
