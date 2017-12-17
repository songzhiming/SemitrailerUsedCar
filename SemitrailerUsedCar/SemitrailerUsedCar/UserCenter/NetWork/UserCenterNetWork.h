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



@end
