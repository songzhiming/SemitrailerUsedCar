//
//  InviteUserViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/27.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "InviteUserViewController.h"
#import "UserInfo.h"

@interface InviteUserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;

@end

@implementation InviteUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"邀请好友注册送 5积分 啦";
    NSMutableAttributedString *attriTitle = [[NSMutableAttributedString alloc]initWithString:title];
    [attriTitle addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(0, title.length)];
    [attriTitle addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#0FA945"]
                    range:NSMakeRange(0, 7)];
    [attriTitle addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#F49F19"]
                       range:NSMakeRange(8, 3)];
    [attriTitle addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#0FA945"]
                       range:NSMakeRange(12, 1)];
    self.titleLabel.attributedText = attriTitle;
    
    NSString *inviteStr = [NSString stringWithFormat:@"您的邀请码为: %@",[UserInfo userinfo].invite_code];
    NSMutableAttributedString *attriinvite = [[NSMutableAttributedString alloc]initWithString:inviteStr];
    [attriinvite addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:19.0f]
                       range:NSMakeRange(0, inviteStr.length)];
    [attriinvite addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#999999"]
                       range:NSMakeRange(0, 7)];
    [attriinvite addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#0FA945"]
                       range:NSMakeRange(7, inviteStr.length - 7)];
    self.inviteCodeLabel.attributedText = attriinvite;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions
- (IBAction)onclickBackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onclickInviteButton:(UIButton *)sender {
    
}

@end
