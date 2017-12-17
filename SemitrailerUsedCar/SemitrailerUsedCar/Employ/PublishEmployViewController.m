//
//  PublishEmployViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/11.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "PublishEmployViewController.h"
#import "SellCarTableViewCell.h"
#import "PickerViewController.h"
#import "CarConfigureManager.h"
#import "InputInfomationViewController.h"

@interface PublishEmployViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSArray *datasource;
@property (nonatomic,strong) NSMutableArray *contentArray;

@end

@implementation PublishEmployViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleTextField:) name:UITextFieldTextDidEndEditingNotification object:nil];
    // Do any additional setup after loading the view from its nib.
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
        id obj = self.contentArray[indexPath.row];
        if (obj && [obj isKindOfClass:[CarConfigureModel class]]) {
            CarConfigureModel *model = (CarConfigureModel *)obj;
            cell.desLabel.text = model.name;
        }
    }else if (indexPath.row == 2){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 3){
        cell.textField.hidden = YES;
        cell.desLabel.hidden = NO;
    }else if (indexPath.row == 4){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.hidden = NO;
        cell.desLabel.hidden = YES;
    }else if (indexPath.row == 5){
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
            __weak PublishEmployViewController *weakSelf = self;
            vc.callBackCarConfigureModel = ^(CarConfigureModel *model) {
                [weakSelf.contentArray replaceObjectAtIndex:indexPath.row withObject:model];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 2:
             {
                 NSLog(@"点击地址");
             }
            break;
        case 3:
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
        case 4:
            break;
        case 5:
            break;
        default:
            break;
    }
}

#pragma mark setter && getter
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = @[@"职位名称",@"薪资",@"工作地址",@"职位介绍",@"联系人",@"联系人电话"];
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
