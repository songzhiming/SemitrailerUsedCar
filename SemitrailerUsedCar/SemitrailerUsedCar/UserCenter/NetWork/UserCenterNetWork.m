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

@end
