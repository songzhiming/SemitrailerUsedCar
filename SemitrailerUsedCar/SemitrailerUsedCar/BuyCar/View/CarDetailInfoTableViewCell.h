//
//  CarDetailInfoTableViewCell.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@interface CarDetailInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) CarModel *model;

+ (CGFloat )heightForCell:(CarModel *)model;

@end
