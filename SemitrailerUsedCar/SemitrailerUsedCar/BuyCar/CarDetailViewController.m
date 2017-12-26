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
#import "LoginViewController.h"
#import "BasicNavigationViewController.h"
#import "CheckPriceTipModel.h"
#import "RechargeViewController.h"
@interface CarDetailViewController ()<UIAlertViewDelegate>
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

- (void)getCheckPriceTip
{
    NSDictionary *dic = @{@"uid":[UserInfo userinfo].id,
                          @"id":self.carId,
                          @"action":@(1)
                          };
    [BuyCarNetWork getCarOrder:dic success:^(YMBaseRequest *request) {
        NSDictionary *data = request.responseObject[@"data"];
        if ([data[@"ordered"] integerValue] == 1) {//已购买
            NSString *mobile = data[@"contact_data"][@"mobile"];
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            if ([data[@"price_data"][@"can"] boolValue] == YES) {//积分足够
                NSString *message = [NSString stringWithFormat:@"本次联系车主将消耗%@积分,目前账号余额为%@积分",data[@"price_data"][@"price"],data[@"price_data"][@"amount"]];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"联系车主", nil];
                alertView.tag = 1000;
                [alertView show];
            }else{
                NSString *message = [NSString stringWithFormat:@"本次联系车主将消耗%@积分,目前账号余额为%@积分",data[@"price_data"][@"price"],data[@"price_data"][@"amount"]];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
                alertView.tag = 1001;
                [alertView show];
            }
        }
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}


- (void)connectCarOwner
{
    NSDictionary *dic = @{@"uid":[UserInfo userinfo].id,
                          @"id":self.carId,
                          @"action":@(2)
                          };
    [BuyCarNetWork connectCarOwner:dic success:^(YMBaseRequest *request) {
        NSDictionary *data = request.responseObject[@"data"];
        NSString *mobile = data[@"contact_data"][@"mobile"];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {//联系车主  扣积分
            [self connectCarOwner];
        }
    }else if (alertView.tag == 1001){//充值
        RechargeViewController *vc = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark actions
- (IBAction)onclickBackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onclickConnectButton:(id)sender {
    if(![UserInfo isLogin]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        BasicNavigationViewController *nav = [[BasicNavigationViewController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self getCheckPriceTip];
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
