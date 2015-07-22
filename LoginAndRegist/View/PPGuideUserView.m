//
//  PPGuideUserView.m
//  招标
//
//  Created by ppan on 15/7/20.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPGuideUserView.h"

@implementation PPGuideUserView


-(id)initWithFrame:(CGRect)frame backImage:(UIImage*)image msgStr:(NSString*)txt
          txtColor:(UIColor*)color{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _paopaoImage = image;
        _txt = txt;
        _color = color;
        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect textRc = rect;
    [_paopaoImage drawInRect:rect];
    CGFontRef contextFont = CGFontCreateWithFontName((CFStringRef)[UIFont systemFontOfSize:14].fontName);
    CFRelease(contextFont);
    
    CGContextSetFontSize(context, 14.0);
    CGContextSetFillColorWithColor(context, _color.CGColor);
    textRc.origin.y += 11.0f;
    [_txt drawInRect:textRc withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
