//
//  CarConfigureManager.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "CarConfigureManager.h"
#import "CarConfigureModel.h"

@interface CarConfigureManager()

@property (nonatomic,strong) NSDictionary *configureDic;

@end


@implementation CarConfigureManager

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self getCarConfigureList];
    }
    
    return self;
}

- (void)getCarConfigureList
{
    if (!self.configureDic) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"carOptions.json" ofType:nil];
            NSData *data = [NSData dataWithContentsOfFile:path];
            self.configureDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.age = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"age"]];
            self.brand = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"brand"]];
            self.horsepower = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"horsepower"]];
            self.mileage = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"mileage"]];
            self.price = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"price"]];
            self.emission = [NSArray yy_modelArrayWithClass:[CarConfigureModel class] json:self.configureDic[@"data"][@"emission"]];
        });
    }
}


@end
