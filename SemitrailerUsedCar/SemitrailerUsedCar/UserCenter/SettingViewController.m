//
//  SettingViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "SettingViewController.h"
#import "BasicWebViewController.h"


@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *memorySizeLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    CGFloat size = (cache.memoryCache.totalCost + cache.diskCache.totalCost)/(1024 * 1024.0);
    self.memorySizeLabel.text = [NSString stringWithFormat:@"%.1fM", size];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (IBAction)onlclickLogoutButton:(UIButton *)sender {
    [UserInfo removeUserInfo];
    [self.navigationController popToRootViewControllerAnimated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        UITabBarController *tabVc = (UITabBarController *)MainWindow.rootViewController;
        tabVc.selectedIndex = 0;
    });

}
- (IBAction)onclickClearButton:(UIButton *)sender {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    // clear cache
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
    self.memorySizeLabel.text = @"0.0M";
    [self showMessage:@"清除成功"];
}
- (IBAction)onclickAboutButton:(UIButton *)sender {
    BasicWebViewController *vc = [[BasicWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
