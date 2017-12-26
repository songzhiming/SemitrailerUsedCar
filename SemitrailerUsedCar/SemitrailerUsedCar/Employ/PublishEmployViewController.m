//
//  PublishEmployViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/11.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "PublishEmployViewController.h"
#import "SellCarTableViewCell.h"
#import "CarConfigureManager.h"
#import "InputInfomationViewController.h"
#import "InputNumberViewController.h"
#import "ChooseAreaViewController.h"
#import "EmployNetWork.h"

@interface PublishEmployViewController ()

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSArray *datasource;
@property (nonatomic,strong) NSMutableArray *contentArray;
@property (nonatomic,assign) NSInteger lowPrice;
@property (nonatomic,assign) NSInteger highPrice;
@property (nonatomic,assign) NSInteger lowWorkAge;
@property (nonatomic,assign) NSInteger highWorkAge;

@end

@implementation PublishEmployViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.lowPrice = -1;
    self.highPrice = -1;
    self.lowWorkAge = -1;
    self.highWorkAge = -1;
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
    self.title = @"发布职位";
    [self.tableView registerNib:[UINib nibWithNibName:@"SellCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"SellCarTableViewCell"];
    self.footerView.frame = CGRectMake(0, 0, kScreenW, 83);
    self.tableView.tableFooterView = self.footerView;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma mark UITextFieldTextDidEndEditingNotification
- (void)handleTextField:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    [self.contentArray replaceObjectAtIndex:textField.tag withObject:textField.text];
}

- (IBAction)onclickSubmitButton:(UIButton *)sender {
    NSLog(@"contentArray--%@",self.contentArray);
    BOOL isComplete = YES;
    for (NSInteger i = 4; i < self.contentArray.count; i++) {
        id obj = self.contentArray[i];
        if (obj && [obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""]) {
            isComplete = NO;
        }
    }
    id obj = self.contentArray[0];
    if (obj && [obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""]) {
        isComplete = NO;
    }
    if (self.lowPrice == -1 || self.highPrice == -1 || self.lowWorkAge == -1 || self.highWorkAge == -1) {
        isComplete = NO;
    }
    if (self.provinceModel == nil || self.cityModel == nil || self.districtModel == nil) {
        isComplete = NO;
    }
    if (isComplete == NO) {
        [self showMessage:@"信息不全,请填写信息"];
        return;
    }
//    idint职位id action为2时需要
//    actionint动作1.职位发布 2.职位修改
//    titlestring职位名称
//    salary_lowint薪资下限
//    salary_highint薪资上限
//    work_age_lowint工作年限下限
//    work_age_highint工作年限上限
//    provinceint工作地点-省
//    cityint工作地点-市
//    countyint工作地点-区县
//    briefstring职位介绍
//    contactstring联系人
//    mobilenumber联系人电话
//    created_byint用户id
    NSDictionary *dic = @{@"action":@"1",
                          @"title":self.contentArray[0],
                          @"salary_low":@(self.lowPrice),
                          @"salary_high":@(self.highPrice),
                          @"work_age_low":@(self.lowWorkAge),
                          @"work_age_high":@(self.highWorkAge),
                          @"province":@(self.provinceModel.id),
                          @"city":@(self.cityModel.id),
                          @"county":@(self.districtModel.id),
                          @"brief":self.contentArray[4],
                          @"contact":self.contentArray[5],
                          @"mobile":self.contentArray[6],
                          @"created_by":[UserInfo userinfo].id
                          };
    [EmployNetWork publishJob:dic success:^(YMBaseRequest *request) {
         [self showMessage:@"发布成功"];
    } failure:^(YMBaseRequest *request, NSError *error) {
        [self showMessage:error.localizedDescription];
    }];
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
    cell.textField.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;

    }else if (indexPath.row == 1){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
        if (self.lowWorkAge == -1 || self.highWorkAge == -1) {
            cell.desLabel.text = @"";
        }else{
            cell.desLabel.text = [NSString stringWithFormat:@"%ld年  ~  %ld年",(long)self.lowWorkAge,(long)self.highWorkAge];
        }
    }else if (indexPath.row == 2){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
        if (self.lowPrice == -1 || self.highPrice == -1) {
            cell.desLabel.text = @"";
        }else{
            cell.desLabel.text = [NSString stringWithFormat:@"%ld  ~  %ld",(long)self.lowPrice,(long)self.highPrice];
        }
    }else if (indexPath.row == 3){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
        if (self.provinceModel && self.cityModel && self.districtModel) {
            cell.desLabel.text = [NSString stringWithFormat:@"%@  %@  %@",self.provinceModel.name,self.cityModel.name,self.districtModel.name];
        }else{
            cell.desLabel.text = @"";
        }
    }else if (indexPath.row == 4){
        cell.desLabel.text = self.contentArray[indexPath.row];
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 5){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }else if (indexPath.row == 6){
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
            InputNumberViewController *vc = [[InputNumberViewController alloc]init];
            vc.inputType = InputTypeWorkAge;
            vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            vc.providesPresentationContextTransitionStyle = YES;
            vc.definesPresentationContext = YES;
            [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            __weak typeof(self) weakself = self;
            vc.callBackPrice = ^(NSInteger lowPrice, NSInteger highPrice) {
                NSLog(@"price---");
                weakself.lowWorkAge = lowPrice;
                weakself.highWorkAge = highPrice;
                [weakself.tableView reloadData];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 2:
        {
            InputNumberViewController *vc = [[InputNumberViewController alloc]init];
            vc.inputType = InputTypePrice;
            vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            vc.providesPresentationContextTransitionStyle = YES;
            vc.definesPresentationContext = YES;
            [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            __weak typeof(self) weakself = self;
            vc.callBackPrice = ^(NSInteger lowPrice, NSInteger highPrice) {
                weakself.lowPrice = lowPrice;
                weakself.highPrice = highPrice;
                [weakself.tableView reloadData];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 3:
             {
                 ChooseAreaViewController *vc = [[ChooseAreaViewController alloc]init];
                 vc.areaType = AreaTypeProvince;
                 vc.parent_id = 0;
                 [self.navigationController pushViewController:vc animated:YES];
                 NSLog(@"点击地址");
             }
            break;
        case 4:
            {
                InputInfomationViewController *vc = [[InputInfomationViewController alloc]init];
                vc.title = @"职位介绍";
                vc.placeHolder = @"请输入职位介绍";
                __weak PublishEmployViewController *weakSelf = self;
                vc.callBackStr = ^(NSString *str) {
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:str];
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 5:
            break;
        case 6:
            break;
        default:
            break;
    }
}

#pragma mark setter && getter
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = @[@"职位名称",@"工作年限",@"薪资",@"工作地址",@"职位介绍",@"联系人",@"联系人电话"];
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
