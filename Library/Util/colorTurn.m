//
//  colorTurn.m
//  招标
//
//  Created by ppan on 15/7/10.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "colorTurn.h"

@implementation colorTurn
+(UIColor *)colorTurnWithRed:(float)redf greed:(float)greedf blue:(float)bluef alpa:(float)alpaf{

    return [UIColor colorWithRed:redf/255.0 green:greedf/255.0 blue:bluef/255.0 alpha:alpaf];

}

+(UIColor *)RGBColorFromHexString:(NSString *)color alpha:(float)alpha { //color的值类似#fffeee,alpha的值类似1.0为透明度
    int nums[6] = {0};
    for (int i = 1; i < [color length]; i++) {
        int temp = [color characterAtIndex:i];
        if (temp >= '0' && temp <= '9') {
            nums[i-1] = [color characterAtIndex:i] - '0';
        }else if(temp >= 'A' && temp <= 'F') {
            nums[i-1] = [color characterAtIndex:i] - 'A' + 10;
        }else if(temp >= 'a' && temp <= 'f') {
            nums[i-1] = [color characterAtIndex:i] - 'a' + 10;
        }else {
            return [UIColor whiteColor];
        }
        
    }
    float rValue = (nums[0] * 16 + nums[1]) / 255.0f;
    float gValue = (nums[2] *16 + nums[3]) / 255.0f;
    float bValue = (nums[4] *16 + nums[5]) / 255.0f;
    UIColor *rgbColor = [UIColor colorWithRed:rValue green:gValue blue:bValue alpha:alpha];
    return rgbColor;
}

@end
