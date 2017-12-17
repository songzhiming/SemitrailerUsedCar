//
//  EmployModel.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployModel : NSObject

//"id": "1",
//"title": "职位名称",
//"salary_low": "1000",
//"salary_high": "1500",
//"work_age_low": "1",
//"work_age_high": "3",
//"province": "1",
//"city": "1",
//"province_name": "北京",
//"city_name": "北京"

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *salary_low;
@property (nonatomic,copy) NSString *salary_high;
@property (nonatomic,copy) NSString *work_age_low;
@property (nonatomic,copy) NSString *work_age_high;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *province_name;
@property (nonatomic,copy) NSString *city_name;

@end
