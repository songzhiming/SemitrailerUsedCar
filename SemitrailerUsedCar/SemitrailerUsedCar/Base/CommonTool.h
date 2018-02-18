//
//  CommonTool.h
//  Law
//
//  Created by zhiming9 on 2018/1/20.
//  Copyright © 2018年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject

// 通过颜色创建图片
+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size;
//判断 是否有相册权限
+ (BOOL)isAllowPhoto;
//判断 是否有相机权限
+ (BOOL)isAllowTakePhoto;
//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email;
//手机号码的正则表达式
+ (BOOL)isValidateMobile:(NSString *)mobile;

@end
