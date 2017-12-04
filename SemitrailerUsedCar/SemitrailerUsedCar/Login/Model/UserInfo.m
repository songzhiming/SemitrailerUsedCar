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
}

//解档
- (id)initWithCoder:(NSCoder *)Decoder{
    if (self = [super init]) {
        self.id = [Decoder decodeObjectForKey:@"id"];
        self.invite_code = [Decoder decodeObjectForKey:@"invite_code"];
        self.mobile = [Decoder decodeObjectForKey:@"mobile"];
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


@end
