//
//  BasicNavigationViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicNavigationViewController.h"
#import "UIColor+Extension.h"

@interface BasicNavigationViewController ()

@end

@implementation BasicNavigationViewController



// 设置导航条的主题

- (void)setupNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置背景图片
    UIImage *backgroundImageForDefaultBarMetrics = [self createImageWithColor:[UIColor colorWithRed:248/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]];
    backgroundImageForDefaultBarMetrics = [backgroundImageForDefaultBarMetrics resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, backgroundImageForDefaultBarMetrics.size.height - 1, backgroundImageForDefaultBarMetrics.size.width - 1)];
    [navBar setBackgroundImage:backgroundImageForDefaultBarMetrics forBarMetrics:UIBarMetricsDefault];
    //去除导航栏边界的黑线
    //    navBar.shadowImage = [[UIImage alloc]init];
    // 1.3.设置文字颜色`
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    md[UITextAttributeTextColor] = [UIColor colorWithHexString:@"#0fa945"];
    // 取出阴影  UIOffset
    md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    // 设置字体大小
    md[UITextAttributeFont] = [UIFont systemFontOfSize:19];
    md[UITextAttributeFont] = [UIFont systemFontOfSize:19];
    [navBar setTitleTextAttributes:md];
}


- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavTheme];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置目标控制器隐藏选项卡
    if (self.childViewControllers.count > 0) {
        // 不是栈底控制器, 也就是子控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



// 返回上一个控制器
- (void)back
{
    [self popViewControllerAnimated:YES];
}

//返回栈底控制器
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{

    return [super popToRootViewControllerAnimated:animated];
}

@end
