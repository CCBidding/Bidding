//
//  UIImage+LBBlurredImage.h
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LBBlurredImage)
-(UIImage*)getBlurImage:(UIImage*)image;  //模糊化图片
- (UIImage*)gaussBlur:(CGFloat)blurLevel andImage:(UIImage*)originImage;
@end
