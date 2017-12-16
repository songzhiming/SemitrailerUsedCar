//
//  InputInfomationViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "InputInfomationViewController.h"
#import "LPlaceholderTextView.h"

@interface InputInfomationViewController ()
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *textView;

@end

@implementation InputInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeholderText = self.placeHolder;
    self.textView.placeholderColor = [UIColor colorWithHexString:@"#BBBBBB"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#0FA945"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)onclickDoneButton
{
    if (self.textView.text.length == 0) {
        [self showMessage:@"请填写内容"];
        return;
    }
    if (self.callBackStr) {
        self.callBackStr(self.textView.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
