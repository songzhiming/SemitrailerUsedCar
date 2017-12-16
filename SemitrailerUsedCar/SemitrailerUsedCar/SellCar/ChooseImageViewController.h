//
//  ChooseImageViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^callBackImage) (NSArray *);

@interface ChooseImageViewController : BasicViewController

@property (nonatomic,copy) callBackImage callBackImage;

@end
