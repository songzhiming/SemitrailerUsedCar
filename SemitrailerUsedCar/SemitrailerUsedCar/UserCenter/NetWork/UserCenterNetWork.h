//
//  UserCenterNetWork.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/11.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterNetWork : NSObject

// 获取个人中心信息
+ (void)getUserInfo:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 我发布的车辆
+ (void)myPublishCarList:(void (^)(YMBaseRequest *request))success
                 failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 已联系的车主
+ (void)myOrderCarList:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 已联系雇主
+ (void)myOrderJobList:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 我发布的职位
+ (void)myPublishJobList:(void (^)(YMBaseRequest *request))success
                 failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 充值列表
+ (void)getRechargeList:(NSDictionary *)params
                success:(void (^)(YMBaseRequest *request))success
                failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 获取积分是否够
+ (void)getPriceTip:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure;



@end
