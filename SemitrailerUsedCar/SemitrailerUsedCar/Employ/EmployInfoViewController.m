//
//  EmployInfoViewController.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "EmployInfoViewController.h"

@interface EmployInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *workAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation EmployInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"招聘详情";
    [self setUpViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViews
{
    self.titleLabel.text = self.model.title;
    self.moneyLabel.text = [NSString stringWithFormat:@"【 %@~%@ 】",self.model.salary_low,self.model.salary_high];
    self.areaLabel.text = [NSString stringWithFormat:@"%@  %@",self.model.province_name,self.model.city_name];
    self.desLabel.text = self.model.brief;
    self.workAgeLabel.text = [NSString stringWithFormat:@"%@~%@年",self.model.work_age_low,self.model.work_age_high];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
