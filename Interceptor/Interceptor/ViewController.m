//
//  ViewController.m
//  Interceptor
//
//  Created by 张永强 on 17/3/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYSecondViewController.h"
#import "ZYInterceptorWithNetwork.h"


@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    ZYInterceptorWithNetwork *network = [ZYInterceptorWithNetwork sharedInstance];
    network.promptStr = @"网络有错";
    network.btnText = @"确定";
    network.title = @"提示";
    [network loadInterceptorWithActionName:@"viewWillAppear:" optionType:AspectPositionAfter error:^(NSError *interceptorError) {
        NSLog(@"拦截错误");
    }];
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
    ZYSecondViewController *second = [[ZYSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
