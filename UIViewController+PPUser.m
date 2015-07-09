//
//  UIViewController+PPUser.m
//  招标
//
//  Created by ppan on 15/7/9.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "UIViewController+PPUser.h"

@implementation UIViewController (PPUser)
-(UIBarButtonItem *)itemWithImage:(UIImage *)normalImage title:(NSString *)title tapBlock:(void (^)(void))block{

    UIBarButtonItem *item;
    CGSize size = [title boundingRectWithSize:CGSizeMake(100, INT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width+23, 40)];
    UIImageView *imageV = [self imageWithFrame:CGRectMake(0, 9.5, 21, 21) image:[UIImage imageNamed:@""] tapBlock:nil];
    
    UILabel *label = [self lableWithFrame:CGRectMake(23, (40-size.height)/2, size.width, size.height) title:title fontSize:18 fontColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft tapBlock:nil];
    [view addSubview:imageV];
    [view addSubview:label];
    [view bk_whenTapped:block];
    
    item = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    return item;


}

-(UIBarButtonItem *)itemWithImage:(UIImage *)normalImage action:(void (^)(id))action{

    return [[UIBarButtonItem alloc] bk_initWithImage:normalImage style:UIBarButtonItemStylePlain handler:action];


}

-(UIBarButtonItem *)itemWithTitle:(NSString *)title action:(void (^)(id))action{

    return [[UIBarButtonItem alloc] bk_initWithTitle:title style:UIBarButtonItemStylePlain handler:action];

}
-(UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage tapBlock:(void (^)(void))block{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn bk_whenTapped:block];
    
    return btn;

}
-(UIImageView *)imageWithFrame:(CGRect)frame image:(UIImage *)normalImage tapBlock:(void (^)(void))block{

    UIImageView *imageV = [[UIImageView alloc]initWithFrame:frame];
    imageV.image = normalImage;
    [imageV bk_whenTapped:block];
    return  imageV;
}

-(UILabel *)lableWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fSize fontColor:(UIColor *)fColor textAligment:(NSTextAlignment *)aligment tapBlock:(void (^)(void))block{

    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = fColor;
    [label bk_whenTapped:block];
    return label;
}
@end
