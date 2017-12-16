//
//  YMShareService.m
//  YMShareCompontentDemo
//
//  Created by 宋志明 on 16/11/22.
//  Copyright © 2016年 宋志明. All rights reserved.
//

#import "YMShareService.h"
#import "YMShareActionSheetView.h"


@interface YMShareService()

@end

@implementation YMShareService

-(id)presentSnsIconSheetViewWithParams:(NSDictionary *)params
{
    [self presentSnsIconSheetView:params[@"shareTitle"]
                         shareUrl:params[@"shareUrl"]
                        shareText:params[@"shareText"]
                       shareImage:params[@"shareImage"]
                     shareOptions:params[@"shareOptions"]
                  shareToSnsNames:params[@"shareToSnsNames"]];
    return nil;
}


-(void)presentSnsIconSheetView:(NSString *)shareTitle
                      shareUrl:(NSString *)shareUrl
                     shareText:(NSString *)shareText
                    shareImage:(id)shareImage
                  shareOptions:(NSDictionary *)options
               shareToSnsNames:(NSArray *)snsNames
{
    NSAssert(shareImage, @"shareImage 必须填");
    YMShareActionSheetView *shareView = [[YMShareActionSheetView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    shareView.title = shareTitle;
    shareView.url = shareUrl;
    shareView.shareText = shareText;
    shareView.shareImage = shareImage;
    shareView.options = options;
    shareView.snsNames = [NSMutableArray arrayWithArray:snsNames];
    [shareView show];
}



@end
