//
//  BasicViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-15.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "BasicViewController.h"
//#import "MBProgressHUD+Add.h"
#import "UIColor+Extension.h"

@interface BasicViewController ()

@property (nonatomic) UIView *loadingImageView;
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7FAF9"];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"back_normal" hightImage:@"back_highlight" customBundleName:@"YMImageResources" target:self action:@selector(comeBack)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}



@end
