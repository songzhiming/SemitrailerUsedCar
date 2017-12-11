//
//  UserInfo.m
//  China-net-app
//
//  Created by 宋志明 on 16/5/19.
//  Copyright © 2016年 张淼. All rights reserved.
//

#import "UserInfo.h"

// 登陆返回保存路径
#define UserInfoFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"UserInfo.arch"]

@implementation UserInfo

//归档
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.id forKey:@"id"];
    [encoder encodeObject:self.invite_code forKey:@"invite_code"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:@(self.amount) forKey:@"amount"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:@(self.order_car) forKey:@"order_car"];
    [encoder encodeObject:@(self.order_job) forKey:@"order_job"];
    [encoder encodeObject:@(self.publish_car) forKey:@"publish_car"];
    [encoder encodeObject:@(self.publish_job) forKey:@"publish_job"];
    [encoder encodeObject:@(self.invite_count) forKey:@"invite_count"];
}

//解档
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.id = [Decoder decodeObjectForKey:@"id"];
        self.invite_code = [Decoder decodeObjectForKey:@"invite_code"];
        self.mobile = [Decoder decodeObjectForKey:@"mobile"];
        self.amount = ((NSNumber *)[Decoder decodeObjectForKey:@"amount"]).integerValue;
        self.avatar = [Decoder decodeObjectForKey:@"avatar"];
        self.order_car = ((NSNumber *)[Decoder decodeObjectForKey:@"order_car"]).integerValue;
        self.order_job = ((NSNumber *)[Decoder decodeObjectForKey:@"order_job"]).integerValue;
        self.publish_car = ((NSNumber *)[Decoder decodeObjectForKey:@"publish_car"]).integerValue;
        self.publish_job = ((NSNumber *)[Decoder decodeObjectForKey:@"publish_job"]).integerValue;
        self.invite_count = ((NSNumber *)[Decoder decodeObjectForKey:@"invite_count"]).integerValue;
    }
    return self;
}

+ (instancetype)userinfo{
    UserInfo *userinfo = [[self alloc] initUserInfo];
    if (!userinfo) {
        return [[self alloc] init];
    }
    return userinfo;
}
// 保存
- (BOOL)saveUserInfoWithDict:(NSDictionary *)dict{
    UserInfo *userInfo = [UserInfo yy_modelWithDictionary:dict];
    return [self saveUserInfo:userInfo];
}

- (BOOL)saveUserInfo:(UserInfo *)userInfo{
    return [NSKeyedArchiver archiveRootObject:userInfo toFile:UserInfoFilePath];
}
- (instancetype)initUserInfo{
    if (self = [super init]) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoFilePath];
    }
    return self;
}
+ (void)removeUserInfo{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:UserInfoFilePath error:nil];
}

+ (BOOL)isLogin
{
    if ([UserInfo userinfo].id) {
        return YES;
    }
    return NO;
}

@end
