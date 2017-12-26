//
//  ChooseAreaViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/17.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "BasicViewController.h"
#import "AreaModel.h"

typedef enum : NSUInteger {
    AreaTypeProvince,
    AreaTypeCity,
    AreaTypeDistrict,
} AreaType;

@interface ChooseAreaViewController : BasicViewController

@property (nonatomic,assign) NSInteger parent_id;
@property (nonatomic,strong) AreaModel *provinceModel;
@property (nonatomic,strong) AreaModel *cityModel;
@property (nonatomic,assign) AreaType areaType;

@end
