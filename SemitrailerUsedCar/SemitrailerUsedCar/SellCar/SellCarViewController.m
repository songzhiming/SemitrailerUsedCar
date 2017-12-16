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
@interface SellCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *datasource;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSMutableArray *contentArray;// 文案数组
@property (nonatomic,strong) NSArray *imageArray;// 图片数组
@property (nonatomic,strong) 
@end

@implementation SellCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.imageArray = [NSArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleTextField:) name:UITextFieldTextDidEndEditingNotification object:nil];
    // Do any additional setup after loading the view from its nib.
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
#pragma mark UITextFieldTextDidEndEditingNotification
- (void)handleTextField:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    [self.contentArray replaceObjectAtIndex:textField.tag withObject:textField.text];
}

- (IBAction)onclickSubmitButton:(UIButton *)sender {
    NSLog(@"self0-0-0---%@",self.contentArray);
    NSLog(@"self0-0-0---%@",self.imageArray);
    BOOL isComplete = YES;
    for (NSString *str in self.contentArray) {
        if ([str isEqualToString:@""]) {
            isComplete = NO;
        }
    }
    if (self.imageArray.count == 0 || isComplete == NO) {//没图片 或者信息不全
        [self showMessage:@"请填写完整信息"];
        return;
    }
    NSDictionary *dic = @{@"created_by":[UserInfo userinfo].id,
                          @"name":self.contentArray[0],
                          @"brand":@"",
                          };
    [SellCarNetWork publishCar:nil success:^(YMBaseRequest *request) {
        
    } failure:^(YMBaseRequest *request, NSError *error) {
        
    }];
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
    cell.desLabel.text = self.contentArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }else if (indexPath.row == 1){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 2){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 3){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 4){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 5){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 6){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 7){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
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
                    [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:@"YES"];
                    weakSelf.imageArray = arr;
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
