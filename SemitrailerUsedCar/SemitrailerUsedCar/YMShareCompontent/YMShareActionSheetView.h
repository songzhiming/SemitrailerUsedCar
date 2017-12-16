//
//  YMShareActionSheetView.h
//  YMShareCompontentDemo
//
//  Created by 宋志明 on 16/11/22.
//  Copyright © 2016年 宋志明. All rights reserved.
//
//  自定义ShareActionSheetView 
#import <UIKit/UIKit.h>

@interface YMShareActionSheetView : UIView

// 分享title
@property (nonatomic,copy)NSString *title;
// 分享url
@property (nonatomic,copy)NSString *url;
// 分享文案
@property (nonatomic,copy)NSString *shareText;
// 分享图片
@property (nonatomic,strong)id shareImage;
// 分享可选字典
@property (nonatomic,strong)NSDictionary *options;
// 分享平台数组
@property (nonatomic,strong)NSMutableArray *snsNames;


-(void)show;

-(void)dismiss;

@end
