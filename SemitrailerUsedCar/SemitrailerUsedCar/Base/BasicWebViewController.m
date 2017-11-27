//
//  BasicWebViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicWebViewController.h"
#import <WebKit/WebKit.h>

@interface BasicWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webview;

@end

@implementation BasicWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = @"https://www.baidu.com/";
    self.webview = [[WKWebView alloc]init];
    self.webview.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//    self.webview.navigationDelegate = self;
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
