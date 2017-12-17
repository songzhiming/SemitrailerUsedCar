//
//  MyPublishJobViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "MyPublishJobViewController.h"
#import "EmployTableViewCell.h"
#import "UserCenterNetWork.h"
#import "EmployModel.h"

@interface MyPublishJobViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation MyPublishJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = [NSMutableArray array];
    [self setupViews];
}

- (void)setupViews
{
    self.title = @"我发布的职位";
    [self.tableview registerNib:[UINib nibWithNibName:@"EmployTableViewCell" bundle:nil] forCellReuseIdentifier:@"EmployTableViewCell"];
    UIView *footerView = [[UIView alloc]init];
    self.tableview.tableFooterView = footerView;
    [self getEmployList];
}

- (void)getEmployList
{
    [UserCenterNetWork myPublishJobList:^(YMBaseRequest *request) {
        [self.datasource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[EmployModel class] json:request.responseObject[@"data"]]];
        [self.tableview reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
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
    EmployTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployTableViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
