//
//  SellCarViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "SellCarViewController.h"
#import "SellCarTableViewCell.h"
@interface SellCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@end

@implementation SellCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"卖车";
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableview registerNib:[UINib nibWithNibName:@"SellCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"SellCarTableViewCell"];
    self.footerView.frame = CGRectMake(0, 0, kScreenW, 83);
    self.tableview.tableFooterView = self.footerView;
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
    SellCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellCarTableViewCell"];
    cell.nameLabel.text = self.datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


#pragma mark setter && getter
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = @[@"车辆名称",@"品牌",@"价格",@"车龄",@"排放标准",@"里程",@"马力",@"车辆简介",@"照片",@"联系人",@"联系人电话"];
    }
    return _datasource;
}



@end
