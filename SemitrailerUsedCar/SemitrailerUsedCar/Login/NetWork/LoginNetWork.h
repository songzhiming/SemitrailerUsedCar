//
//  LoginNetWork.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/2.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginNetWork : NSObject



// 获取验证码
+ (void)getAuthCode:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure;
// 注册
+ (void)registerUser:(NSDictionary *)params
             success:(void (^)(YMBaseRequest *request))success
             failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

// 登录
+ (void)loginUser:(NSDictionary *)params
          success:(void (^)(YMBaseRequest *request))success
          failure:(void (^)(YMBaseRequest *request, NSError *error))failure;

//忘记密码
+ (void)forgetPassword:(NSDictionary *)params
               success:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure;



@end
