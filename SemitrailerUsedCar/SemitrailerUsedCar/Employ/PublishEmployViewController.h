//
//  PublishEmployViewController.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/11.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import "AreaModel.h"

@interface PublishEmployViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) AreaModel *provinceModel;
@property (nonatomic,strong) AreaModel *cityModel;
@property (nonatomic,strong) AreaModel *districtModel;

@end
