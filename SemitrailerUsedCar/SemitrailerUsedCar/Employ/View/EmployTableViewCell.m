//
//  EmployTableViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/1.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "EmployTableViewCell.h"
@interface EmployTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation EmployTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(EmployModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
}

@end
