//
//  LoginNetWork.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/2.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "LoginNetWork.h"

@implementation LoginNetWork


// 获取验证码
+ (void)getAuthCode:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"send-code";
    request.requestArgument = params;
    request.requestMethod = YMRequestMethodPOST;
    [request startWithCompletionBlockWithSuccess:^(__kindof YMBaseRequest * _Nonnull request) {
        // todo   responseObject model
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

// 注册
+ (void)registerUser:(NSDictionary *)params
             success:(void (^)(YMBaseRequest *request))success
             failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"register";
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

// 登录
+ (void)loginUser:(NSDictionary *)params
          success:(void (^)(YMBaseRequest *request))success
          failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"login";
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

//忘记密码
+ (void)forgetPassword:(NSDictionary *)params
               success:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"forget";
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
