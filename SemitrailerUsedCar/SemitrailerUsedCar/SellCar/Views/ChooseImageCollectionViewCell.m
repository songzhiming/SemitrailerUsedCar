//
//  ChooseImageCollectionViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2018/2/18.
//  Copyright © 2018年 zhiming9. All rights reserved.
//

#import "ChooseImageCollectionViewCell.h"

@implementation ChooseImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)onclickDeleteButton:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

@end
