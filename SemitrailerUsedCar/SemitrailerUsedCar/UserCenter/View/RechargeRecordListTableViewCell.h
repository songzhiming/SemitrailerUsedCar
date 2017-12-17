//
//  RechargeRecordListTableViewCell.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeModel.h"

@interface RechargeRecordListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,strong) RechargeModel *model;

@end
