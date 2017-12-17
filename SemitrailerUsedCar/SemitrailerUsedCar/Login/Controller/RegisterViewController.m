//
//  RegisterViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/13.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginNetWork.h"


@interface RegisterViewController ()
{
    NSTimer *timer;
    NSInteger sec;
    bool countstate;     //倒计时状态
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *authCodeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
}


//倒计时
-(void)onTimer{
    sec = sec - 1;
    if (sec == 0) {
        [  timer invalidate];
        [self.authCodeButton setEnabled:YES];
        countstate=NO;
        [self.authCodeButton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateDisabled];
    }else{
        [self.authCodeButton  setTitle:[NSString stringWithFormat:@"%@%ld)",@"重新发送(",(long)sec] forState:UIControlStateDisabled];
    }
}


#pragma mark actions
- (IBAction)onclickGetAuthCodeButton:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showMessage:@"手机号码格式错误"];
        return;
    }
    NSDictionary *dic = @{@"mobile":self.phoneTextField.text,
                          @"type":@"1"
                          };
    self.authCodeButton.enabled = NO;
    [LoginNetWork getAuthCode:dic success:^(YMBaseRequest *request) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats: YES];
        sec=60;
        [self.authCodeButton setTitle:[NSString stringWithFormat:@"%@%ld)",@"重新发送(",(long)sec] forState:UIControlStateDisabled];
    } failure:^(YMBaseRequest *request, NSError *error) {
        self.authCodeButton.enabled = YES;
        [self showMessage:error.localizedDescription];
    }];
}
- (IBAction)onclickRigisterButton:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showMessage:@"手机号码格式错误"];
        return;
    }
    if (self.passWordTextField.text.length == 0 || self.surePassWordTextField.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (![self.passWordTextField.text isEqualToString:self.surePassWordTextField.text]) {
        [self showMessage:@"两次密码不同"];
        return;
    }
    if (self.authCodeTextField.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    NSDictionary *params = @{@"mobile":self.phoneTextField.text,
                             @"password":self.passWordTextField.text,
                             @"password_repeat":self.surePassWordTextField.text,
                             @"code":self.authCodeTextField.text
                             };
    [LoginNetWork registerUser:params success:^(YMBaseRequest *request) {
        [self showMessage:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}


@end
