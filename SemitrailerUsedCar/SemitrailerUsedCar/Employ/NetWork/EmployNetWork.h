//
//  EmployNetWork.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/4.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployNetWork : NSObject

// 获取招聘列表
+ (void)getEmployList:(NSDictionary *)params
              success:(void (^)(YMBaseRequest *request))success
              failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 获取招聘地区列表
+ (void)getEmployAreaList:(NSDictionary *)params
                  success:(void (^)(YMBaseRequest *request))success
                  failure:(void (^)(YMBaseRequest *request, NSError *error))failure;
// 发布职位
+ (void)publishJob:(NSDictionary *)params
           success:(void (^)(YMBaseRequest *request))success
           failure:(void (^)(YMBaseRequest *request, NSError *error))failure;
@end
