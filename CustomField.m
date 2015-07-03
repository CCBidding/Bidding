//
//  CustomField.m
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "CustomField.h"

@implementation CustomField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5));
    
    
}


@end
