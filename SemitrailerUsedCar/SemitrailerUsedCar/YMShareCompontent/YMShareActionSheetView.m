//
//  YMShareActionSheetView.m
//  YMShareCompontentDemo
//
//  Created by 宋志明 on 16/11/22.
//  Copyright © 2016年 宋志明. All rights reserved.
//

#import "YMShareActionSheetView.h"
#import "YMShareItemCollectionViewCell.h"
#import "WXApi.h"
#import "YMShareConst.h"
#import <UMSocialCore/UMSocialCore.h>



@interface YMShareActionSheetView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *containView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSDictionary *snsDic;
@property (nonatomic,strong)NSDictionary *snsUmeng;
@property (nonatomic,strong)UIButton *cancelButton;
@end
@implementation YMShareActionSheetView
static NSString *kCellId = @"YMShareItemCollectionViewCell";
static CGFloat kItemHeight = 125.0;

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self _setup];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self _setup];
    }
    
    return self;
}
// 初始化view
- (void)_setup
{
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
    self.containView = [[UIView alloc]init];
    self.collectionView = ({
        UICollectionViewFlowLayout *categoryFlowLayout = [UICollectionViewFlowLayout new];
        CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
        categoryFlowLayout.itemSize = CGSizeMake(width, kItemHeight);
        categoryFlowLayout.minimumInteritemSpacing = 0;
        categoryFlowLayout.minimumLineSpacing = 0;
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.origin.y = frame.size.height - 50;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:categoryFlowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:kCellId bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCellId];
        collectionView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
        [self.containView addSubview:collectionView];
        collectionView;
    });
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenH, kScreenW, 50)];
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:self.cancelButton];
    [self addSubview:self.containView];
}

#pragma mark -
- (void)show
{
    int count ;
//    if (![WXApi isWXAppInstalled]) {//如果没装微信，隐藏
//        [self.snsNames removeObject:YMShareSnsTypeWechatTimeline];
//        [self.snsNames removeObject:YMShareSnsTypeWechatSession];
//    }
//    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {//如果没装QQ，隐藏
//        [self.snsNames removeObject:YMShareSnsTypeQQ];
//        [self.snsNames removeObject:YMShareSnsTypeQzone];
//    }
    if (self.snsNames.count%4 == 0) {
        count = (int)self.snsNames.count/4;
    }else{
        count = (int)self.snsNames.count/4 + 1;
    }

    [self.collectionView reloadData];
    self.containView.frame = CGRectMake(0, kScreenH, kScreenW, count*kItemHeight + 50);
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, count*kItemHeight);
    self.cancelButton.frame = CGRectMake(0, count*kItemHeight, kScreenW, 50);
    UIWindow *mainWindow =  [[[UIApplication sharedApplication] delegate] window];
    [mainWindow addSubview:self];
    [mainWindow bringSubviewToFront:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.containView.frame = CGRectMake(0, kScreenH - count*kItemHeight - 50, kScreenW, count*kItemHeight + 50);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.containView.frame;
        frame.origin.y = kScreenH;
        self.containView.frame = frame;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - collectionView delegate & dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.snsNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YMShareItemCollectionViewCell *cell =(YMShareItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    NSString *snsImage = [NSString stringWithFormat:@"YMShare_%@_icon",[self.snsNames[indexPath.row] stringByReplacingOccurrencesOfString:@"YMShareSnsType" withString:@""]];
    cell.iconImageView.image = [self imagesNamedFromCustomBundle:snsImage];
    cell.iconLabel.text = self.snsDic[self.snsNames[indexPath.row]];
    return cell;
};


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //todo
    [self dismiss];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.shareText thumImage:self.shareImage];
    shareObject.webpageUrl = self.url;
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:[self.snsUmeng[self.snsNames[indexPath.row]] integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
            }else{
            }
        }
    }];
}

#pragma mark private method
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"YMShareResources.bundle"];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:img_path];
}

#pragma mark - setter & getter
- (NSDictionary *)snsDic
{
    if (!_snsDic) {
        _snsDic = @{YMShareSnsTypeQQ:@"QQ",
                    YMShareSnsTypeWechatSession:@"微信好友",
                    YMShareSnsTypeWechatTimeline:@"朋友圈",
                    YMShareSnsTypeSina:@"微博",
                    YMShareSnsTypeQzone:@"QQ空间",
                    YMShareSnsTypeNameCard:@"名片夹"};
    }
    return _snsDic;
}
- (NSDictionary *)snsUmeng
{
    if (!_snsUmeng) {
        _snsUmeng = @{YMShareSnsTypeQQ:@(UMSocialPlatformType_QQ),
                      YMShareSnsTypeWechatSession:@(UMSocialPlatformType_WechatSession),
                      YMShareSnsTypeWechatTimeline:@(UMSocialPlatformType_WechatTimeLine),
                      YMShareSnsTypeSina:@(UMSocialPlatformType_Sina),
                      YMShareSnsTypeQzone:@(UMSocialPlatformType_Qzone)};
    }
    return _snsUmeng;
}

- (UIViewController *)currentlyViewController {
    
    //通过递归拿到当前控制器
    UIViewController *activityViewController;
    
    //    UIWindow *window;
    //    NSArray *windows = [[UIApplication sharedApplication] windows];
    //    for(UIWindow *tmpWin in windows)
    //    {
    //        if(tmpWin.windowLevel == UIWindowLevelNormal)
    //        {
    //            window = tmpWin;
    //            break;
    //        }
    //    }
    //
    //    NSArray *viewsArray = [window subviews];
    //
    //    if([viewsArray count] > 0){
    //        for ( UIView *frontView in viewsArray) {
    //            UIResponder *next = frontView.nextResponder;
    //            while (next) {
    //                if ([next isKindOfClass:[UIViewController class]]) {
    //                    activityViewController = (UIViewController *)next;
    //                    break;
    //                }
    //                next = next.nextResponder;
    //            }
    //        }
    //    }
    activityViewController = [self recursionControllerFrom:[UIApplication sharedApplication].delegate.window.rootViewController];
    return activityViewController;
}

- (UIViewController *)recursionControllerFrom:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)controller;
        return [self recursionControllerFrom:navigationController.viewControllers.lastObject];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)controller;
        return [self recursionControllerFrom:tabbarController.selectedViewController];
    } else if (controller.presentedViewController != nil) {
        return [self recursionControllerFrom:(UIViewController *)controller.presentedViewController];
    } else {
        return controller;
    }
}

@end
