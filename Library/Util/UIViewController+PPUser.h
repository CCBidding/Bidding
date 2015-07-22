//
//  UIViewController+PPUser.h
//  招标
//
//  Created by ppan on 15/7/9.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PPUser)
/**
 * c创建UIbarbuttonItem
 *
 * @param normalImage 有图像
 * @param title 有标题
 * @param tapBlock 有点击效果
 * 
 * @return 返回一个UIBarButtonItem
 */

-(UIBarButtonItem *)itemWithImage:(UIImage *)normalImage  title:(NSString *)title
                         tapBlock:(void(^)(void))block;


/**
 *创建一个UIBarButtonItem
 *
 * @param normalImage 图像
 * @param action 点击效果
 * @return 返回一个UIBarButtonItem
 
 
 */

-(UIBarButtonItem *)itemWithImage:(UIImage *)normalImage action:(void(^)(id sender))action;

/**
 *创建一个UIBarButtonItem
 *@param title 标题
 *@param action 点击效果
 * @return 返回一个UIBarButtonItem
 */

-(UIBarButtonItem *)itemWithTitle:(NSString *)title action:(void(^)(id sender))action;

-(UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)normalImage  selectedImage:(UIImage *)selectedImage tapBlock:(void(^)(void))block;

-(UIImageView *)imageWithFrame:(CGRect)frame image:(UIImage *)normalImage
                                            tapBlock:(void(^)(void))block;

-(UILabel *)lableWithFrame:(CGRect)frame title:(NSString *)title
                                         fontSize:(CGFloat)fSize
                                        fontColor:(UIColor *)fColor
                                       textAligment :(NSTextAlignment *)aligment
                                        tapBlock:(void (^)(void))block;



@end
