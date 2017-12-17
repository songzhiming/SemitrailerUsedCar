//
//  MyPublishCarListViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "MyPublishCarListViewController.h"
#import "BuyCarTableViewCell.h"
#import "MJRefresh.h"
#import "UserCenterNetWork.h"
#import "CarDetailViewController.h"

@interface MyPublishCarListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation MyPublishCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发布的车";
    self.datasource = [NSMutableArray array];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyCarTableViewCell"];
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself getCarList];
    }];
    UIView *footerView = [[UIView alloc]init];
    self.tableView.tableFooterView = footerView;
    [self.tableView headerBeginRefreshing];
}

- (void)getCarList
{
    [UserCenterNetWork myPublishCarList:^(YMBaseRequest *request) {
        self.datasource = [NSArray yy_modelArrayWithClass:[CarModel class] json:request.responseObject[@"data"]].mutableCopy;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self showMessage:error.localizedDescription];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyCarTableViewCell"];
    cell.model = self.datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CarDetailViewController *vc = [[CarDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
