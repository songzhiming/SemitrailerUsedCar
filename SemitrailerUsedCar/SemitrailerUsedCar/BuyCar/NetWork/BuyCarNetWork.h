//
//  BuyCarNetWork.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyCarNetWork : NSObject

// 获取车辆列表
//brand int品牌
//price number价格
//age int车龄
//emission int排放标准
//mileage int里程
//horsepower int马力
+ (void)getCarList:(NSInteger )brand
             price:(NSInteger )price
               age:(NSInteger )age
          emission:(NSInteger )emission
           mileage:(NSInteger )mileage
        horsepower:(NSInteger )horsepower
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

@end
