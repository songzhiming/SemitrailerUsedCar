//
//  RechargeRecordListViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "RechargeRecordListViewController.h"
#import "RechargeRecordListTableViewCell.h"
#import "MJRefresh.h"
#import "UserCenterNetWork.h"
#import "RechargeModel.h"

@interface RechargeRecordListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *datasource;
@end

@implementation RechargeRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    [self setupViews];
}

- (void)setupViews
{
    self.datasource = [NSMutableArray array];
    [self.tableview registerNib:[UINib nibWithNibName:@"RechargeRecordListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RechargeRecordListTableViewCell"];
    __weak typeof(self) weakself = self;
    [self.tableview addHeaderWithCallback:^{
        [weakself getRechargeList];
    }];
    UIView *footerView = [[UIView alloc]init];
    self.tableview.tableFooterView = footerView;
    [self.tableview headerBeginRefreshing];
}

- (void)getRechargeList
{
    [UserCenterNetWork getRechargeList:nil success:^(YMBaseRequest *request) {
        NSArray *data = [NSArray yy_modelArrayWithClass:[RechargeModel class] json:request.responseObject[@"data"]];
        [self.datasource addObjectsFromArray:data];
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self.tableview headerEndRefreshing];
        [self showMessage:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordListTableViewCell"];
    cell.model = self.datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
