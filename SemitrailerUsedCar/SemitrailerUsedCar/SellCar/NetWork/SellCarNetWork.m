//
//  SellCarNetWork.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "SellCarNetWork.h"

@implementation SellCarNetWork

// 卖车
+ (void)publishCar:(NSDictionary *)params
           success:(void (^)(YMBaseRequest *request))success
           failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"car-publish";
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

// 上传图片
+ (void)uploadImage:(UIImage *)image
            success:(void (^)(YMBaseRequest *request))success
            failure:(void (^)(YMBaseRequest *request, NSError *error))failure
{
    YMBaseRequest *request = [[YMBaseRequest alloc]init];
    request.requestUrl = @"attachment-upload";
    request.requestArgument = nil;
    request.requestMethod = YMRequestMethodUpload;
    request.constructingBodyBlock = ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image,0.75) name:@"picture" fileName:@"picture" mimeType:@"image/jpg"];
    };
    [request uploadFileWithprogressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"progress---%@",progress);
    } success:^(__kindof YMBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] intValue] == 10000){
            success(request);
        }else{
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:request.responseObject[@"msg"]};
            NSError *error = [[NSError alloc]initWithDomain:@"" code:[request.responseObject[@"code"] intValue] userInfo:userInfo];
            failure(request,error);
        }
    } failure:^(__kindof YMBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request,request.error);
        }
    }];
}

@end
