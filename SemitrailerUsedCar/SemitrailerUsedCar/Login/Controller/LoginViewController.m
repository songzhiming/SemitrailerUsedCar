//
//  LoginViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/13.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwViewController.h"
#import "LoginNetWork.h"
#import "UserInfo.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (IBAction)onclickCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onclickLoginButton:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showMessage:@"手机号码格式错误"];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    NSDictionary *params = @{@"mobile":self.phoneTextField.text,
                             @"password":self.passwordTextField.text
                             };
    [LoginNetWork loginUser:params success:^(YMBaseRequest *request) {
        [[UserInfo userinfo]saveUserInfoWithDict:request.responseObject[@"data"]];
        [self showMessage:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
    
}
- (IBAction)onclickForgetPwButton:(UIButton *)sender {
    ForgetPwViewController *vc = [[ForgetPwViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)onclickRegiserButton:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
