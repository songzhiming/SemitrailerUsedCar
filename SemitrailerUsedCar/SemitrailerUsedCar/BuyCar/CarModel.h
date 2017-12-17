//
//  CarModel.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

//"id": "9",
//"name": "车辆名称",
//"brand": "江淮",
//"age": "1年以下",
//"emission": "国二",
//"mileage": "10万公里以下",
//"horsepower": "0〜150匹",
//"price": "1.00万",
//"cover": "http://localhost:8080/upload/product/car_5a0c56438449a.jpeg"

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *brand;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *emission;
@property (nonatomic,copy) NSString *mileage;
@property (nonatomic,copy) NSString *horsepower;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *cover;
@end
