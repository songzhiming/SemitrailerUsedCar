//
//  EmployNetWork.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/4.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "EmployNetWork.h"

@implementation EmployNetWork
// 获取招聘列表
+ (void)getEmployList:(NSDictionary *)params
              success:(void (^)(YMBaseRequest *request))success
              failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"job-list";
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

// 获取招聘地区列表
+ (void)getEmployAreaList:(NSDictionary *)params
                  success:(void (^)(YMBaseRequest *request))success
                  failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"job-area-options";
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

// 发布职位
+ (void)publishJob:(NSDictionary *)params
           success:(void (^)(YMBaseRequest *request))success
           failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"job-publish";
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
