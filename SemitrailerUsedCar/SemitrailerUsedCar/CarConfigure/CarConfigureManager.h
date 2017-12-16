//
//  CarConfigureManager.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarConfigureManager : NSObject

+ (instancetype)sharedInstance;

// 品牌
@property (nonatomic,strong) NSArray *brand;
// 车龄
@property (nonatomic,strong) NSArray *age;
// 价格
@property (nonatomic,strong) NSArray *price;
// 里程
@property (nonatomic,strong) NSArray *mileage;
// 马力
@property (nonatomic,strong) NSArray *horsepower;
// 排行标准
@property (nonatomic,strong) NSArray *emission;
@end
