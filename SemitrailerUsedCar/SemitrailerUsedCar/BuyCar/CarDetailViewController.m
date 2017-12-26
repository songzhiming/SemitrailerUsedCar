//
//  CarDetailViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "CarDetailViewController.h"
#import "CarDetailCarouselTableViewCell.h"
#import "CarDetailInfoTableViewCell.h"
#import "BuyCarNetWork.h"
#import "MJRefresh.h"
@interface CarDetailViewController ()
@property (nonatomic,strong) CarModel *model;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.tableView registerNib:[UINib nibWithNibName:@"CarDetailCarouselTableViewCell" bundle:nil] forCellReuseIdentifier:@"CarDetailCarouselTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CarDetailInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CarDetailInfoTableViewCell"];
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself getCarInfo];
    }];
    [self.tableView headerBeginRefreshing];
}

- (void)getCarInfo
{
    NSDictionary *dic = @{@"id":self.carId};
    [BuyCarNetWork getCarInfo:dic success:^(YMBaseRequest *request) {
        self.model = [CarModel yy_modelWithJSON:request.responseObject[@"data"]];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self showMessage:error.localizedDescription];
    }];
}

#pragma mark actions
- (IBAction)onclickBackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onclickConnectButton:(id)sender {
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CarDetailCarouselTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarDetailCarouselTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datasource = self.model.pictures.mutableCopy;
        [cell.collectionView reloadData];
        return cell;
    }else{
        CarDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarDetailInfoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 280.0/375.0*kScreenW;
    }else{
        return [CarDetailInfoTableViewCell heightForCell:nil];
    }
}


@end
