//
//  UserInfo.h
//  China-net-app
//
//  Created by 宋志明 on 16/5/19.
//  Copyright © 2016年 张淼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

//用户唯一id
@property (nonatomic,copy) NSString *id;
//邀请码
@property (nonatomic,copy) NSString *invite_code;
//手机号码
@property (nonatomic,copy) NSString *mobile;

+ (instancetype)userinfo;
// 保存UserInfo
- (BOOL)saveUserInfoWithDict:(NSDictionary *)dict;
- (BOOL)saveUserInfo:(UserInfo *)userInfo;
// 删除UserInfo
+ (void)removeUserInfo;
@end
