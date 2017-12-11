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
//
@property (nonatomic,assign) NSInteger amount;
//
@property (nonatomic,copy) NSString *avatar;
//
@property (nonatomic,assign) NSInteger order_car;
//
@property (nonatomic,assign) NSInteger order_job;
//
@property (nonatomic,assign) NSInteger publish_car;
//
@property (nonatomic,assign) NSInteger publish_job;
//
@property (nonatomic,assign) NSInteger invite_count;

+ (instancetype)userinfo;
// 保存UserInfo
- (BOOL)saveUserInfoWithDict:(NSDictionary *)dict;
- (BOOL)saveUserInfo:(UserInfo *)userInfo;
// 删除UserInfo
+ (void)removeUserInfo;
+ (BOOL)isLogin;
@end
