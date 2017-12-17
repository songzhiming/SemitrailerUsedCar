//
//  RechargeModel.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject

//"way": "微信",
//"amount": "11.00",
//"created_at": "1511092346"

@property (nonatomic,copy) NSString *way;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *created_at;

@end
