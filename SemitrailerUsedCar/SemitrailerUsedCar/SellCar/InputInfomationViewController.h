//
//  InputInfomationViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/16.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^callBackStr) (NSString *);
// 填写信息
@interface InputInfomationViewController : BasicViewController

@property (nonatomic,copy) NSString *placeHolder;
@property (nonatomic,copy) callBackStr callBackStr;
@end
