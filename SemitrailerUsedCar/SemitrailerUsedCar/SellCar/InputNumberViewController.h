//
//  InputNumberViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/24.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^callBackPrice) (NSInteger lowPrice,NSInteger highPrice);
typedef enum : NSUInteger {
    InputTypePrice,
    InputTypeWorkAge,
} InputType;

@interface InputNumberViewController : BasicViewController

@property (nonatomic,copy) callBackPrice callBackPrice;

@property (nonatomic,assign) InputType inputType;

@end
