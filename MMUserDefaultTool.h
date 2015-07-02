//
//  MMUserDefaultTool.h
//  Manito
//
//  Created by Johnny on 15/4/27.
//  Copyright (c) 2015年 com.Manito.apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMUserDefaultTool : NSObject

+ (void)setObject:(id)objct forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;
+ (BOOL)isEmptyForKey:(NSString *)key;

@end
