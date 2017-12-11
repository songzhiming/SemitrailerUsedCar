//
//  UserCenterViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterTableViewCell.h"
#import "SettingViewController.h"
#import "RechargeViewController.h"
#import "UserCenterNetWork.h"

@interface UserCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self setupViews];
    [self getUserInfo];
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
- (void)setupViews
{
    self.avatarImageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    [self.tableview registerNib:[UINib nibWithNibName:@"UserCenterTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserCenterTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark network
- (void)getUserInfo
{
    if (![UserInfo isLogin]) {
        return;
    }
    [UserCenterNetWork getUserInfo:@{@"uid":[UserInfo userinfo].id} success:^(YMBaseRequest *request) {
        [[UserInfo userinfo]saveUserInfoWithDict:request.responseObject[@"data"]];
//        [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:[UserInfo userinfo].avatar]] placeholder:nil];
        self.nameLabel.text = [UserInfo userinfo].mobile;
        [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:[UserInfo userinfo].avatar] placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
        [self.tableview reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}


#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasource.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = (NSArray *)self.datasource[section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterTableViewCell"];
    NSArray *items = (NSArray *)self.datasource[indexPath.section];
    NSDictionary *dic = items[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell.nameLabel.text = dic[@"name"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//积分
            cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserInfo userinfo].amount];
        }else if (indexPath.row == 2){
            cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserInfo userinfo].order_car];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserInfo userinfo].publish_job];
        }else{
            cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserInfo userinfo].order_job];
        }
    }else{
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserInfo userinfo].invite_count];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.datasource[indexPath.section][indexPath.row];
    NSString *vcName = dic[@"vc"];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark actions
- (IBAction)onclickSettingButton:(UIButton *)sender {
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)onclickGotoChargeButton:(UIButton *)sender {
    RechargeViewController *vc = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark setter && getter
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = @[@[@{@"icon":@"mine_integral",
                            @"name":@"积分",
                            @"vc":@"BasicWebViewController",
                            },
                          @{@"icon":@"mine_recharge",
                            @"name":@"充值记录",
                            @"vc":@"RechargeRecordListViewController",
                            },
                          @{@"icon":@"mine_connect",
                            @"name":@"已联系车主",
                            @"vc":@"MyConnectViewController",
                            }],
                        @[@{@"icon":@"mine_releaseOffer",
                              @"name":@"我发表的职位",
                              @"vc":@"",
                              },
                            @{@"icon":@"mine_connectOffer",
                              @"name":@"我联系的职位",
                              @"vc":@"",
                              }],
                        @[@{@"icon":@"mine_invite",
                            @"name":@"邀请好友",
                            @"vc":@"",
                            }],
                        
        ];
    }
    return _datasource;
}

@end
