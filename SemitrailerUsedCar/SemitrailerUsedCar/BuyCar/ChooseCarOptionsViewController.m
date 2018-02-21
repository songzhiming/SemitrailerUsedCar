//
//  ChooseCarOptionsViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2018/2/21.
//  Copyright © 2018年 zhiming9. All rights reserved.
//

#import "ChooseCarOptionsViewController.h"
#import "CarOptionTableViewCell.h"
#import "CarConfigureManager.h"
#import "CarConfigureModel.h"

@interface ChooseCarOptionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;

@end

@implementation ChooseCarOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"CarOptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"CarOptionTableViewCell"];
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.tableview.tableFooterView = footerView;
    if (self.chooseCarOptionsType == ChooseCarOptionsTypeBrand) {
        self.datasource = [[CarConfigureManager sharedInstance] brand];
    }else if (self.chooseCarOptionsType == ChooseCarOptionsTypeAge){
        self.datasource = [[CarConfigureManager sharedInstance] age];
    }else if (self.chooseCarOptionsType == ChooseCarOptionsTypePrice){
        self.datasource = [[CarConfigureManager sharedInstance] price];
    }else if (self.chooseCarOptionsType == ChooseCarOptionsTypeMileage){
        self.datasource = [[CarConfigureManager sharedInstance] mileage];
    }else if (self.chooseCarOptionsType ==  ChooseCarOptionsTypeHorsepower){
        self.datasource = [[CarConfigureManager sharedInstance] horsepower];
    }
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarOptionTableViewCell"];
    CarConfigureModel *model = self.datasource[indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CarDetailViewController *vc = [[CarDetailViewController alloc]init];
//    CarModel *model = self.datasource[indexPath.row];
//    vc.carId = model.id;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
