//
//  ForgetPwViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/13.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ForgetPwViewController.h"
#import "ConfirmPwViewController.h"
#import "LoginNetWork.h"

@interface ForgetPwViewController ()
{
    NSTimer *timer;
    NSInteger sec;
    bool countstate;     //倒计时状态
}

@property (weak, nonatomic) IBOutlet UIButton *authCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;

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

#pragma mark actions
- (IBAction)onclickGetAuthCodeButton:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showMessage:@"手机号码格式错误"];
        return;
    }
    NSDictionary *dic = @{@"mobile":self.phoneTextField.text,
                          @"type":@"2"
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


- (IBAction)onclickNextButton:(UIButton *)sender {
    if (self.phoneTextField.text.length != 11) {
        [self showMessage:@"手机号码格式错误"];
        return;
    }
    if (self.authCodeTextField.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    ConfirmPwViewController *vc = [[ConfirmPwViewController alloc]init];
    vc.phone = self.phoneTextField.text;
    vc.authCode = self.authCodeTextField.text;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
