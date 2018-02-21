//
//  ChooseCarOptionsViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2018/2/21.
//  Copyright © 2018年 zhiming9. All rights reserved.
//

#import "BasicViewController.h"

//// 品牌
//@property (nonatomic,strong) NSArray *brand;
//// 车龄
//@property (nonatomic,strong) NSArray *age;
//// 价格
//@property (nonatomic,strong) NSArray *price;
//// 里程
//@property (nonatomic,strong) NSArray *mileage;
//// 马力
//@property (nonatomic,strong) NSArray *horsepower;
//// 排行标准
//@property (nonatomic,strong) NSArray *emission;
typedef enum : NSUInteger {
    ChooseCarOptionsTypeBrand,//品牌
    ChooseCarOptionsTypeAge, //车龄
    ChooseCarOptionsTypePrice, //价格
    ChooseCarOptionsTypeMileage,//里程
    ChooseCarOptionsTypeHorsepower //马力
} ChooseCarOptionsType;

@interface ChooseCarOptionsViewController : BasicViewController

@property (nonatomic,assign) ChooseCarOptionsType chooseCarOptionsType;

@end
