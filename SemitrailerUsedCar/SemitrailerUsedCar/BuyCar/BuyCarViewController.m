//
//  BuyCarViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BuyCarViewController.h"
#import "BuyCarTableViewCell.h"
#import "BuyCarNetWork.h"
#import "CarModel.h"
#import "MJRefresh.h"
#import "CarDetailViewController.h"
@interface BuyCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *searchView;

//POST参数
//brand int品牌
//price number价格
//age int车龄
//mileage int里程
//horsepower int马力
// 品牌
@property (nonatomic,assign) NSInteger brand;
// 价格
@property (nonatomic,assign) NSInteger price;
// 车龄
@property (nonatomic,assign) NSInteger age;
// 里程
@property (nonatomic,assign) NSInteger mileage;
// 马力
@property (nonatomic,assign) NSInteger horsepower;

@property (nonatomic,strong) NSArray *datasource;

@end

@implementation BuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买车";
    self.datasource = [NSArray array];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    self.navigationItem.leftBarButtonItem = nil;
    self.searchView.frame = CGRectMake(0, 0, kScreenW, 44);
    [self.navigationController.navigationBar addSubview:self.searchView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyCarTableViewCell"];
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself getCarList];
    }];
    UIView *footerView = [[UIView alloc]init];
    self.tableView.tableFooterView = footerView;
    self.brand = 0;
    self.price = 0;
    self.age = 0;
    self.mileage = 0;
    self.horsepower = 0;
    [self.tableView headerBeginRefreshing];
}

- (void)getCarList
{
    [BuyCarNetWork getCarList:self.brand price:self.price age:self.age emission:0 mileage:self.mileage horsepower:self.horsepower success:^(YMBaseRequest *request) {
        self.datasource = [NSArray yy_modelArrayWithClass:[CarModel class] json:request.responseObject[@"data"]];
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
    CarModel *model = self.datasource[indexPath.row];
    vc.carId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
