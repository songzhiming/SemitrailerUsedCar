//
//  UIImage+Small.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/7/23.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
@interface UIImage (Small)
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count);
static void releaseAssetCallback(void *info);
- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size;
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

- (NSString *)base64String;
@end
