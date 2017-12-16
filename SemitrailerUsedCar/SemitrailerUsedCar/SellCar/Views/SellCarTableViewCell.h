//
//  SellCarTableViewCell.h
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/11/6.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellCarTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
//



@end
