//
//  CarDetailCarouselTableViewCell.m
//  SemitrailerUsedCar
//
//  Created by zhiming9 on 2017/12/26.
//  Copyright © 2017年 zhiming9. All rights reserved.
//

#import "CarDetailCarouselTableViewCell.h"
#import "CarDetailCarouselCollectionViewCell.h"
#import <YYWebImage/YYImageCache.h>
@interface CarDetailCarouselTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>



@end

@implementation CarDetailCarouselTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews
{
    self.datasource = [[NSMutableArray alloc]init];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CarDetailCarouselCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CarDetailCarouselCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarDetailCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarDetailCarouselCollectionViewCell" forIndexPath:indexPath];
    [cell.imageview yy_setImageWithURL:[NSURL URLWithString:self.datasource[indexPath.row]] placeholder:nil];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
