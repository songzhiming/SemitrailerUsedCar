//
//  EmployInfoViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "EmployInfoViewController.h"
#import "EmployNetWork.h"
#import "LoginViewController.h"
#import "BasicNavigationViewController.h"
#import "RechargeViewController.h"

@interface EmployInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *workAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (nonatomic,strong) EmployModel *model;

@end

@implementation EmployInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"招聘详情";
    [self getJobInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getJobInfo
{
    NSDictionary *dic = @{@"id":self.jobId,
                          @"action":@"1"
                          };
    [EmployNetWork getJobInfo:dic success:^(YMBaseRequest *request) {
        self.model = [EmployModel yy_modelWithJSON:request.responseObject[@"data"]];
        [self setUpViews];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}

- (void)setUpViews
{
    self.titleLabel.text = self.model.title;
    self.moneyLabel.text = [NSString stringWithFormat:@"【 %@~%@ 】",self.model.salary_low,self.model.salary_high];
    self.areaLabel.text = [NSString stringWithFormat:@"%@  %@",self.model.province_name,self.model.city_name];
    self.desLabel.text = self.model.brief;
    self.workAgeLabel.text = [NSString stringWithFormat:@"%@~%@年",self.model.work_age_low,self.model.work_age_high];
}
- (IBAction)onclickConnectButton:(UIButton *)sender {
    if(![UserInfo isLogin]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        BasicNavigationViewController *nav = [[BasicNavigationViewController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self getCheckPriceTip];
}

- (void)getCheckPriceTip
{
    NSDictionary *dic = @{@"uid":[UserInfo userinfo].id,
                          @"id":self.jobId,
                          @"action":@(1)
                          };
    [EmployNetWork getJobOrder:dic success:^(YMBaseRequest *request) {
        NSDictionary *data = request.responseObject[@"data"];
        if ([data[@"ordered"] integerValue] == 1) {//已购买
            NSString *mobile = data[@"contact_data"][@"mobile"];
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            if ([data[@"price_data"][@"can"] boolValue] == YES) {//积分足够
                NSString *message = [NSString stringWithFormat:@"本次联系将消耗%@积分,目前账号余额为%@积分",data[@"price_data"][@"price"],data[@"price_data"][@"amount"]];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"联系车主", nil];
                alertView.tag = 1000;
                [alertView show];
            }else{
                NSString *message = [NSString stringWithFormat:@"本次联系将消耗%@积分,目前账号余额为%@积分",data[@"price_data"][@"price"],data[@"price_data"][@"amount"]];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
                alertView.tag = 1001;
                [alertView show];
            }
        }
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}
- (void)connectJobOwner
{
    NSDictionary *dic = @{@"uid":[UserInfo userinfo].id,
                          @"id":self.jobId,
                          @"action":@(2)
                          };
    [EmployNetWork getJobOrder:dic success:^(YMBaseRequest *request) {
        NSDictionary *data = request.responseObject[@"data"];
        NSString *mobile = data[@"contact_data"][@"mobile"];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {//发表  扣积分
            [self connectJobOwner];
        }
    }else if (alertView.tag == 1001){//充值
        RechargeViewController *vc = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
