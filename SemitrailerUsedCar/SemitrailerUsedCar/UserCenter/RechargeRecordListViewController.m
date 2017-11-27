//
//  RechargeRecordListViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "RechargeRecordListViewController.h"
#import "RechargeRecordListTableViewCell.h"

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
    [self.tableview registerNib:[UINib nibWithNibName:@"RechargeRecordListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RechargeRecordListTableViewCell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordListTableViewCell"];
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
