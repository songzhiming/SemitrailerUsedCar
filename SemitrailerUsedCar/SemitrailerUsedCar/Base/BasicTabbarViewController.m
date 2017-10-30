//
//  BasicTabbarViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicTabbarViewController.h"
#import "BasicNavigationViewController.h"
#import "BuyCarViewController.h"
#import "SellCarViewController.h"
#import "EmployViewController.h"
#import "UserCenterViewController.h"
#import "UIColor+Extension.h"

@interface BasicTabbarViewController ()

@end

@implementation BasicTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BuyCarViewController *buyCarVc = [[BuyCarViewController alloc]init];
    [self addOneChildController:buyCarVc title:@"买车" norImage:@"tabbar_buy_normal" selectedImage:@"tabbar_buy_selected"];
    SellCarViewController *sellCarVc = [[SellCarViewController alloc]init];
    [self addOneChildController:sellCarVc title:@"卖车" norImage:@"tabbar_sell_normal" selectedImage:@"tabbar_sell_selected"];
    EmployViewController *employVc = [[EmployViewController alloc]init];
    [self addOneChildController:employVc title:@"招聘" norImage:@"tabbar_employ_normal" selectedImage:@"tabbar_employ_selected"];
    UserCenterViewController *userCenter = [[UserCenterViewController alloc]init];
    [self addOneChildController:userCenter title:@"我的" norImage:@"tabbar_my_normal" selectedImage:@"tabbar_my_selected"];
    // Do any additional setup after loading the view.
}

- (void)addOneChildController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage
{
    //设置tabbar图片不被渲染
    self.tabBar.tintColor = [UIColor colorWithHexString:@"0fa945"];
    //设置tabBar背景颜色不被改变
    self.tabBar.backgroundColor = [UIColor whiteColor];
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:norImage];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    BasicNavigationViewController  *nav = [[BasicNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
