//
//  ForgetPwViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/13.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ForgetPwViewController.h"
#import "ConfirmPwViewController.h"

@interface ForgetPwViewController ()

@end

@implementation ForgetPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onclickNextButton:(UIButton *)sender {
    ConfirmPwViewController *vc = [[ConfirmPwViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
