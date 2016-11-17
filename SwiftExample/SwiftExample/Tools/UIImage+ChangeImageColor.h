//
//  UIImage+ChangeImageColor.h
//  Lock
//
//  Created by 李云鹏 on 16/3/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ChangeImageColor)

/**
 *  查看一张图片的主色调
 */
- (UIColor *)mostColor;

/**
 *  将图片改成指定的色调风格
 */
- (UIImage *)changeImageWithColor:(UIColor *)color;
- (UIImage *)changeImageWithTintColor:(UIColor *)tintColor;
- (UIImage *)changeImageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *)changeImageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 *  去除图片的白色背景, 除去图片的白色背景(接近白色)，或者其它颜色的替换
 */
- (UIImage*)eraserImageWhiteColor;

/**
 *  gauss模糊
 */
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyLightEffectWithValue:(CGFloat)sliderValue;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;// 模糊半径;主色调;饱和度;面罩image

/**
 *  截取图片的某一部分
 */
- (UIImage *)subImageInRect:(CGRect)rect;

/**
 *  截取图片的一个圆形区域
 */
- (UIImage*)circleImageWithParam:(CGFloat)inset;

/**
 *  将image缩放到指定尺寸
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 *  图片加水印
 */
-(UIImage *)watermarkImagewithName:(NSString *)name;


@end
