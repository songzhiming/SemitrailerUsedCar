//
//  BuyCarViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BuyCarViewController.h"
#import "BuyCarTableViewCell.h"

@interface BuyCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *searchView;

@end

@implementation BuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买车";
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    self.searchView.frame = CGRectMake(0, 0, kScreenW, 44);
    [self.navigationController.navigationBar addSubview:self.searchView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"BuyCarTableViewCell"];
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
