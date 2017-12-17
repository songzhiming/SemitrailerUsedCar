//
//  PickerViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "PickerViewController.h"


@interface PickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) CarConfigureModel *model;
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选照片";
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.model = self.datasource[0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onclickCancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onclickSureButton:(UIButton *)sender {
    self.callBackCarConfigureModel(self.model);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIPickerViewDelegate && UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datasource.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    CarConfigureModel *model = self.datasource[row];
    return model.name;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    self.model = self.datasource[row];
}

@end
