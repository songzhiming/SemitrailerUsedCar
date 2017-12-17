//
//  ChooseImageViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ChooseImageViewController.h"

@interface ChooseImageViewController ()

@end

@implementation ChooseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#0FA945"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onclickDoneButton
{
    self.callBackImage(@[@"http://f.hiphotos.baidu.com/image/pic/item/5bafa40f4bfbfbed5e3bf76c72f0f736afc31f47.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/c9fcc3cec3fdfc03434927abde3f8794a4c226f4.jpg"]);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
