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
@end
