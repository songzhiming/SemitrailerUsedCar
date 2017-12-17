//
//  BuyCarTableViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/9.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BuyCarTableViewCell.h"

@interface BuyCarTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation BuyCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CarModel *)model
{
    _model = model;
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:model.cover] placeholder:nil];
    self.nameLabel.text = [NSString stringWithFormat:@"%@   %@",model.name,model.horsepower];
    self.describeLabel.text = [NSString stringWithFormat:@"%@    %@   %@",model.brand,model.age,model.mileage];
    self.moneyLabel.text = model.price;
}

@end
