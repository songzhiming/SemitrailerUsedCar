//
//  MyConnectViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "MyConnectViewController.h"
#import "BuyCarTableViewCell.h"

@interface MyConnectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MyConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    self.title = @"已联系车主";
    [self.tableview registerNib:[UINib nibWithNibName:@"BuyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyCarTableViewCell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
