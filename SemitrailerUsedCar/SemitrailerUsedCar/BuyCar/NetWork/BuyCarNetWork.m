//
//  BuyCarNetWork.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BuyCarNetWork.h"

@implementation BuyCarNetWork

+ (void)getCarList:(NSInteger )brand
             price:(NSInteger )price
               age:(NSInteger )age
          emission:(NSInteger )emission
           mileage:(NSInteger )mileage
        horsepower:(NSInteger )horsepower
           success:(void (^)(YMBaseRequest *request))success
           failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"car-list";
    request.requestArgument = @{@"brand":@(brand),
                                @"price":@(price),
                                @"age":@(age),
                                @"emission":@(emission),
                                @"mileage":@(mileage),
                                @"horsepower":@(horsepower)
                                };
    request.requestMethod = YMRequestMethodPOST;
    [request startWithCompletionBlockWithSuccess:^(__kindof YMBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] intValue] == 10000) {//成功
            success(request);
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:request.responseObject[@"msg"]};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[request.responseObject[@"code"] intValue] userInfo:userInfo];
            failure(request,error);
        }
    } failure:^(__kindof YMBaseRequest * _Nonnull request) {
        failure(request,request.error);
    }];
}

// 获取车辆详情
+ (void)getCarInfo:(NSDictionary *)params
           success:(void (^)(YMBaseRequest *request))success
           failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"car-detail";
    request.requestArgument = params;
    request.requestMethod = YMRequestMethodPOST;
    [request startWithCompletionBlockWithSuccess:^(__kindof YMBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] intValue] == 10000) {//成功
            success(request);
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:request.responseObject[@"msg"]};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[request.responseObject[@"code"] intValue] userInfo:userInfo];
            failure(request,error);
        }
    } failure:^(__kindof YMBaseRequest * _Nonnull request) {
        failure(request,request.error);
    }];
}

@end
