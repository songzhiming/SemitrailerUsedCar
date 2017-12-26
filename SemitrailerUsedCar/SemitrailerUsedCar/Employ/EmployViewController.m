//
//  EmployViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "EmployViewController.h"
#import "EmployTableViewCell.h"
#import "LoginViewController.h"
#import "BasicNavigationViewController.h"
#import "EmployNetWork.h"
#import "EmployModel.h"
#import "PublishEmployViewController.h"
#import "EmployInfoViewController.h"

@interface EmployViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;

@end

@implementation EmployViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = [NSArray array];
    [self setupViews];
}

- (void)setupViews
{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"司机招聘";
    label.textColor = [UIColor colorWithHexString:@"#0fa945"];
    label.font = [UIFont systemFontOfSize:19];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableview registerNib:[UINib nibWithNibName:@"EmployTableViewCell" bundle:nil] forCellReuseIdentifier:@"EmployTableViewCell"];
    UIView *footerView = [[UIView alloc]init];
    self.tableview.tableFooterView = footerView;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"employ_release"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickReleaseButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self getEmployList];
}

- (void)getEmployList
{
    [EmployNetWork getEmployList:nil success:^(YMBaseRequest *request) {
        self.datasource = [NSArray yy_modelArrayWithClass:[EmployModel class] json:request.responseObject[@"data"]];
        [self.tableview reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark actions
- (void)onclickReleaseButton:(UIButton *)sender {
    if(![UserInfo isLogin]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        BasicNavigationViewController *nav = [[BasicNavigationViewController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    PublishEmployViewController *vc = [[PublishEmployViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmployTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployTableViewCell"];
    cell.model = self.datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EmployInfoViewController *vc = [[EmployInfoViewController alloc]init];
    vc.model = self.datasource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
