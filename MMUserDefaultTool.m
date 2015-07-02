//
//  MMUserDefaultTool.m
//  Manito
//
//  Created by Johnny on 15/4/27.
//  Copyright (c) 2015年 com.Manito.apps. All rights reserved.
//

#import "MMUserDefaultTool.h"

@implementation MMUserDefaultTool

+ (void)setObject:(id)objct forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:objct forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return obj;
}

+ (void)removeObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isEmptyForKey:(NSString *)key
{
    BOOL isEmpty = YES;
    id a = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (a && [a length] && ![[NSString stringWithFormat:@"%@",[MMUserDefaultTool objectForKey:key]] isEqual:@"(null)"]) {
        isEmpty = NO;
    }
    return isEmpty;
}


@end
