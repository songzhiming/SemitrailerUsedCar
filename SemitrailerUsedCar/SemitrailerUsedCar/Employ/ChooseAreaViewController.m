//
//  ChooseAreaViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "ChooseAreaViewController.h"
#import "EmployNetWork.h"
#import "EmployAreaTableViewCell.h"
#import "AreaModel.h"
#import "PublishEmployViewController.h"

@interface ChooseAreaViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation ChooseAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.areaType == AreaTypeProvince) {
        self.title = @"选择省";
    }else if (self.areaType == AreaTypeCity){
        self.title = @"选择市";
    }else{
        self.title = @"选择区";
    }
    self.datasource = [[NSMutableArray alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"EmployAreaTableViewCell" bundle:nil] forCellReuseIdentifier:@"EmployAreaTableViewCell"];
    [self getAreaList];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取地区列表
- (void)getAreaList
{
    NSDictionary *dic = @{@"parent_id":@(self.parent_id)};
    [EmployNetWork getEmployAreaList:dic success:^(YMBaseRequest *request) {
        self.datasource = [NSArray yy_modelArrayWithClass:[AreaModel class] json:request.responseObject[@"data"]].mutableCopy;
        [self.tableView reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmployAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployAreaTableViewCell"];
    AreaModel *model = self.datasource[indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.areaType == AreaTypeDistrict) {
        PublishEmployViewController *vc = (PublishEmployViewController *)self.navigationController.viewControllers[1];
        vc.provinceModel = self.provinceModel;
        vc.cityModel = self.cityModel;
        vc.districtModel = self.datasource[indexPath.row];
        [vc.tableView reloadData];
        [self.navigationController popToViewController:vc animated:YES];
    }else{
        ChooseAreaViewController *vc = [[ChooseAreaViewController alloc]init];
        AreaModel *model = self.datasource[indexPath.row];
        vc.title = model.name;
        vc.parent_id = model.id;
        if (self.areaType == AreaTypeProvince) {
            vc.areaType = AreaTypeCity;
            vc.provinceModel = model;
        }else{
            vc.areaType = AreaTypeDistrict;
            vc.provinceModel = self.provinceModel;
            vc.cityModel = model;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
