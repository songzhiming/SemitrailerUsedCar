//
//  CarDetailInfoTableViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "CarDetailInfoTableViewCell.h"

@interface CarDetailInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *horsepowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation CarDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat )heightForCell:(CarModel *)model;
{
    return 81 + 16 + 195 + 16 + 100;
}

- (void)setModel:(CarModel *)model
{
    _model = model;
    self.titleLabel.text = model.name;
    self.moneyLabel.text = model.price;
    self.mileageLabel.text = model.mileage;
    self.ageLabel.text = model.age;
    self.horsepowerLabel.text = model.horsepower;
    self.brandLabel.text = model.brand;
    self.desLabel.text = model.brief;
    self.createTimeLabel.text =  model.created_at;
//    self.areaLabel.text =
}
@end
