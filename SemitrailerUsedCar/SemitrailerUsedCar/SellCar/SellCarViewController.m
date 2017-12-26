//
//  SellCarViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/10/30.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "SellCarViewController.h"
#import "SellCarTableViewCell.h"
#import "InputInfomationViewController.h"
#import "ChooseImageViewController.h"
#import "PickerViewController.h"
#import "CarConfigureManager.h"
#import "SellCarNetWork.h"
#import "UserCenterNetWork.h"
#import "CheckPriceTipModel.h"
#import "RechargeViewController.h"
@interface SellCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSMutableArray *contentArray;// 文案数组
@property (nonatomic,strong) CheckPriceTipModel *checkPriceTipModel;
@end

@implementation SellCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self getPriceTip];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleTextField:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setupViews
{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"我要卖车";
    label.textColor = [UIColor colorWithHexString:@"#0fa945"];
    label.font = [UIFont systemFontOfSize:19];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableview registerNib:[UINib nibWithNibName:@"SellCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"SellCarTableViewCell"];
    self.footerView.frame = CGRectMake(0, 0, kScreenW, 83);
    self.tableview.tableFooterView = self.footerView;
    self.tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)getPriceTip
{
    NSDictionary *dic = @{@"uid":[UserInfo userinfo].id,
                          @"type":@(1)
                          };
    [UserCenterNetWork getPriceTip:dic success:^(YMBaseRequest *request) {
        self.checkPriceTipModel = [CheckPriceTipModel yy_modelWithJSON:request.responseObject[@"data"]];
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
}

#pragma mark UITextFieldTextDidEndEditingNotification
- (void)handleTextField:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    [self.contentArray replaceObjectAtIndex:textField.tag withObject:textField.text];
}

- (IBAction)onclickSubmitButton:(UIButton *)sender {
    BOOL isComplete = YES;
    for (id obj in self.contentArray) {
        if (obj && [obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""]) {
            isComplete = NO;
        }
    }
    for (NSInteger i = 1; i < 7; i++) {
        id obj = self.contentArray[i];
        if (![obj isKindOfClass:[CarConfigureModel class]]) {
            isComplete = NO;
        }
    }
    id obj = self.contentArray[8];
    if (![obj isKindOfClass:[NSArray class]]) {
        isComplete = NO;
    }
    if (isComplete == NO) {
        [self showMessage:@"信息不全,请填写信息"];
        return;
    }
    if (self.checkPriceTipModel.can) {//积分够
        NSString *message = [NSString stringWithFormat:@"本次发表将消耗%ld积分,目前账号余额为%ld积分",self.checkPriceTipModel.price,self.checkPriceTipModel.amount];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发表", nil];
        alertView.tag = 1000;
        [alertView show];
    }else{
        NSString *message = [NSString stringWithFormat:@"本次发表将消耗%ld积分,目前账号余额为%ld积分",self.checkPriceTipModel.price,self.checkPriceTipModel.amount];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
        alertView.tag = 1001;
        [alertView show];
    }
}

- (void)sellCar
{
    CarConfigureModel *brand = self.contentArray[1];
    CarConfigureModel *price = self.contentArray[2];
    CarConfigureModel *age = self.contentArray[3];
    CarConfigureModel *emission = self.contentArray[4];
    CarConfigureModel *mileage = self.contentArray[5];
    CarConfigureModel *horsepower = self.contentArray[6];
    NSString *imageUrl = @"";
    id obj = self.contentArray[8];
    NSArray *imageArr = (NSArray *)obj;
    for (NSString *url in imageArr) {
        if ([imageUrl isEqualToString:@""]) {
            imageUrl = [NSString stringWithFormat:@"%@",url];
        }else{
            imageUrl = [NSString stringWithFormat:@"%@,%@",imageUrl,url];
        }
    }
    NSDictionary *dic = @{@"created_by":[UserInfo userinfo].id,
                          @"name":self.contentArray[0],
                          @"brand":brand.value,
                          @"price":price.value,
                          @"age":age.value,
                          @"emission":emission.value,
                          @"mileage":mileage.value,
                          @"horsepower":horsepower.value,
                          @"brief":self.contentArray[7],
                          @"contact":self.contentArray[9],
                          @"mobile":self.contentArray[10],
                          @"pictures":imageUrl
                          };
    [SellCarNetWork publishCar:dic success:^(YMBaseRequest *request) {
        [self showMessage:@"发布成功"];
        [self.contentArray removeAllObjects];
        for (int i = 0; i < self.datasource.count; i++) {
            [_contentArray addObject:@""];
        }
        [self.tableview reloadData];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {//发表  扣积分
            [self sellCar];
        }
    }else if (alertView.tag == 1001){//充值
        RechargeViewController *vc = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    cell.textField.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }else if (indexPath.row == 1 ||
              indexPath.row == 2 ||
              indexPath.row == 3 ||
              indexPath.row == 4 ||
              indexPath.row == 5 ||
              indexPath.row == 6 ){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
        id obj = self.contentArray[indexPath.row];
        if (obj && [obj isKindOfClass:[CarConfigureModel class]]) {
            CarConfigureModel *model = (CarConfigureModel *)obj;
            cell.desLabel.text = model.name;
        }else{
            cell.desLabel.text = @"";
        }
    }else if (indexPath.row == 7){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
        cell.desLabel.text = self.contentArray[indexPath.row];
    }else if (indexPath.row == 8){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 9){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }else if (indexPath.row == 10){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            {
                PickerViewController *vc = [[PickerViewController alloc]init];
                vc.datasource = [[CarConfigureManager sharedInstance] brand];
                vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                vc.providesPresentationContextTransitionStyle = YES;
                vc.definesPresentationContext = YES;
                [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 2:
            {
                PickerViewController *vc = [[PickerViewController alloc]init];
                vc.datasource = [[CarConfigureManager sharedInstance] price];
                vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                vc.providesPresentationContextTransitionStyle = YES;
                vc.definesPresentationContext = YES;
                [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 3:
            {
                PickerViewController *vc = [[PickerViewController alloc]init];
                vc.datasource = [[CarConfigureManager sharedInstance] age];
                vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                vc.providesPresentationContextTransitionStyle = YES;
                vc.definesPresentationContext = YES;
                [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 4:
            {
                PickerViewController *vc = [[PickerViewController alloc]init];
                vc.datasource = [[CarConfigureManager sharedInstance] emission];
                vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                vc.providesPresentationContextTransitionStyle = YES;
                vc.definesPresentationContext = YES;
                [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 5:
            {
                PickerViewController *vc = [[PickerViewController alloc]init];
                vc.datasource = [[CarConfigureManager sharedInstance] mileage];
                vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                vc.providesPresentationContextTransitionStyle = YES;
                vc.definesPresentationContext = YES;
                [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 6:
           {
               PickerViewController *vc = [[PickerViewController alloc]init];
               vc.datasource = [[CarConfigureManager sharedInstance] horsepower];
               vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
               vc.providesPresentationContextTransitionStyle = YES;
               vc.definesPresentationContext = YES;
               [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
               __weak SellCarViewController *weakSelf = self;
               vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                   [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                   [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
               };
               [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }
            break;
        case 7:
            {
                InputInfomationViewController *vc = [[InputInfomationViewController alloc]init];
                vc.title = @"车辆简介";
                vc.placeHolder = @"请输入车辆简介";
                __weak SellCarViewController *weakSelf = self;
                vc.callBackStr = ^(NSString *str) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:str];
                    [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 8:
            {
                ChooseImageViewController *vc = [[ChooseImageViewController alloc]init];
                __weak SellCarViewController *weakSelf = self;
                vc.callBackImage = ^(NSArray *arr) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:arr];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 9:
            break;
        case 10:
            break;
        default:
            break;
    }
}

#pragma mark setter && getter
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = @[@"车辆名称",@"品牌",@"价格",@"车龄",@"排放标准",@"里程",@"马力",@"车辆简介",@"照片",@"联系人",@"联系人电话"];
    }
    return _datasource;
}

- (NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSMutableArray arrayWithCapacity:self.datasource.count];
        for (int i = 0; i < self.datasource.count; i++) {
            [_contentArray addObject:@""];
        }
    }
    return _contentArray;
}



@end
