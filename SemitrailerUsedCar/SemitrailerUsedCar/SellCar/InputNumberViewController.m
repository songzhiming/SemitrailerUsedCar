//
//  InputNumberViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/24.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "InputNumberViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface InputNumberViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lowestPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *highestPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation InputNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    if (self.inputType == InputTypePrice) {
        self.lowestPriceLabel.placeholder = @"请输入价格";
        self.highestPriceLabel.placeholder = @"请输入价格";
        self.desLabel.text = @"最低价格不得 》最高价格";
    }else if (self.inputType == InputTypeWorkAge){
        self.lowestPriceLabel.placeholder = @"请输入工作年限";
        self.highestPriceLabel.placeholder = @"请输入工作年限";
        self.desLabel.text = @"最低工作年限不得 》最高工作年限";
    }
    [self.lowestPriceLabel becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//键盘将要出现
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    NSValue *value = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];//使用UIKeyboardFrameBeginUserInfoKey,会出现切换输入法时获取的搜狗键盘不对.
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    self.inputView.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
}

//键盘将要隐藏
- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    self.inputView.transform = CGAffineTransformIdentity;
}

- (void)textFieldDidChanged:(NSNotification *)paramNotification
{
    if (self.lowestPriceLabel.text.length > 0 && self.highestPriceLabel.text.length > 0) {
        NSString *lowText = self.lowestPriceLabel.text;
        NSString *highText = self.highestPriceLabel.text;
        if (highText.integerValue >= lowText.integerValue) {
            self.doneButton.enabled = YES;
        }else{
            self.doneButton.enabled = NO;
        }
    }else{
        self.doneButton.enabled = NO;
    }
}

#pragma mark actions

- (IBAction)onclickCancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onclickSureButton:(UIButton *)sender {
    self.callBackPrice(self.lowestPriceLabel.text.integerValue, self.highestPriceLabel.text.integerValue);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
