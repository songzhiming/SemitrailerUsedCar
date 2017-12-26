//
//  UserCenterNetWork.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/11.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "UserCenterNetWork.h"
#import "UserInfo.h"

@implementation UserCenterNetWork

// 获取个人中心信息
+ (void)getUserInfo:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"profile";
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

// 我发布的车辆
+ (void)myPublishCarList:(void (^)(YMBaseRequest *request))success
                 failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"published-cars";
    request.requestArgument = @{@"uid":[UserInfo userinfo].id};
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

// 已联系的车主
+ (void)myOrderCarList:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"ordered-cars";
    request.requestArgument = @{@"uid":[UserInfo userinfo].id};
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

// 已联系雇主
+ (void)myOrderJobList:(void (^)(YMBaseRequest *request))success
               failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"ordered-jobs";
    request.requestArgument = @{@"uid":[UserInfo userinfo].id};
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

// 我发布的职位
+ (void)myPublishJobList:(void (^)(YMBaseRequest *request))success
                 failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"published-jobs";
    request.requestArgument = @{@"uid":[UserInfo userinfo].id};
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

// 充值列表
+ (void)getRechargeList:(NSDictionary *)params
                success:(void (^)(YMBaseRequest *request))success
                failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"recharge-list";
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

// 获取积分是否够
+ (void)getPriceTip:(NSDictionary *)params
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"price-tips";
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
