//
//  AllocDeallocViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-15.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AllocDeallocViewController.h"
#import "LogTool.h"

@interface AllocDeallocViewController ()

@end

@implementation AllocDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef DEBUG
static NSMutableDictionary *s_allocInfo;
#endif

#pragma mark - init and dealloc
- (id)init {
    if (self = [super init]) {
        [self doctorInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self doctorInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self doctorInit];
    }
    return self;
}

- (void)doctorInit {
#ifdef DEBUG
    FLOG(@"----------------创建类----------------%@", NSStringFromClass([self class]));
    if (!s_allocInfo) {
        s_allocInfo = [NSMutableDictionary dictionary];
    }
    
    s_allocInfo[NSStringFromClass([self class])] = @([s_allocInfo[NSStringFromClass([self class])] intValue] + 1);
    FLOG(@"%@", s_allocInfo);
#endif
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#ifdef DEBUG
    FLOG(@"----------------释放类----------------%@",  NSStringFromClass([self class]));
    s_allocInfo[NSStringFromClass([self class])] = @([s_allocInfo[NSStringFromClass([self class])] intValue] - 1);
    if ([s_allocInfo[NSStringFromClass([self class])] intValue] == 0) {
        [s_allocInfo removeObjectForKey:NSStringFromClass([self class])];
    }
    FLOG(@"%@", s_allocInfo);
   
#endif
}


@end
