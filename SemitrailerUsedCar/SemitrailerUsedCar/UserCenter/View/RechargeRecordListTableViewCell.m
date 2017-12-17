//
//  RechargeRecordListTableViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "RechargeRecordListTableViewCell.h"

@implementation RechargeRecordListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
//@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)setModel:(RechargeModel *)model
{
    _model = model;
    self.titleLabel.text = @"付款成功";
    self.timeLabel.text = model.created_at;
    self.payWayLabel.text = model.way;
    self.moneyLabel.text = model.amount;
}

@end
