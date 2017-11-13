//
//  BasicViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-15.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "BasicViewController.h"
//#import "MBProgressHUD+Add.h"
#import "UIColor+Extension.h"

@interface BasicViewController ()

@property (nonatomic) UIView *loadingImageView;
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7FAF9"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)comeBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}



@end
