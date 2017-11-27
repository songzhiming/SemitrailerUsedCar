//
//  SettingViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "SettingViewController.h"
#import "BasicWebViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (IBAction)onlclickLogoutButton:(UIButton *)sender {
    
}
- (IBAction)onclickClearButton:(UIButton *)sender {
    
}
- (IBAction)onclickAboutButton:(UIButton *)sender {
    BasicWebViewController *vc = [[BasicWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
