//
//  MyConnectViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "MyConnectViewController.h"
#import "BuyCarTableViewCell.h"
#import "UserCenterNetWork.h"
#import "MJRefresh.h"

@interface MyConnectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation MyConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    self.datasource = [NSMutableArray array];
    self.title = @"已联系车主";
    [self.tableview registerNib:[UINib nibWithNibName:@"BuyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyCarTableViewCell"];
    __weak typeof(self) weakself = self;
    [self.tableview addHeaderWithCallback:^{
        [weakself getCarList];
    }];
    UIView *footerView = [[UIView alloc]init];
    self.tableview.tableFooterView = footerView;
    [self.tableview headerBeginRefreshing];
}

- (void)getCarList
{
    [UserCenterNetWork myOrderCarList:^(YMBaseRequest *request) {
        NSArray *data = [NSArray yy_modelArrayWithClass:[CarModel class] json:request.responseObject[@"data"]];
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

@end
