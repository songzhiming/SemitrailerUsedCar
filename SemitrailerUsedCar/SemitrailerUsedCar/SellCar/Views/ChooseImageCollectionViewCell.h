//
//  ChooseImageCollectionViewCell.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2018/2/18.
//  Copyright © 2018年 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseImageCollectionViewCellBlock)(void);

@interface ChooseImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic,copy) ChooseImageCollectionViewCellBlock block;

@end
