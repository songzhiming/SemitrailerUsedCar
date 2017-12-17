//
//  ConfirmPwViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/13.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ConfirmPwViewController.h"
#import "LoginNetWork.h"

@interface ConfirmPwViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;

@end

@implementation ConfirmPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (IBAction)onclickSubmitButton:(UIButton *)sender {
    if (self.passwordTextField.text.length == 0 || self.surePasswordTextField.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.surePasswordTextField.text]) {
        [self showMessage:@"两次密码不同"];
        return;
    }
    NSDictionary *dic = @{@"mobile":self.phone,
                          @"code":self.authCode,
                          @"password":self.passwordTextField.text,
                          @"password_repeat":self.surePasswordTextField.text
                          };
    [LoginNetWork forgetPassword:dic success:^(YMBaseRequest *request) {
        [self showMessage:@"修改密码成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}



@end
