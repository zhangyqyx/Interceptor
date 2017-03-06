//
//  ZYSecondViewController.m
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYSecondViewController.h"
#import "ZYThreeViewController.h"
#import "ZYInterceptorWithNetwork.h"

@interface ZYSecondViewController ()

@end

@implementation ZYSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(gotoNet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)gotoNet {
    ZYThreeViewController *three= [[ZYThreeViewController alloc] init];
    //跳转的地方设置失去作用
    three.isDisabledInterceptor = YES;
    [self.navigationController pushViewController:three animated:YES];
}


@end
