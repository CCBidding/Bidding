//
//  PPPingYinSearch.h
//  招标
//
//  Created by ppan on 15/7/28.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPPingYinSearch : NSObject
/**
 *  搜索数组，返回新的数组。目前支持NSString，NSDictionnary，自定义Model，后面两个可以指定按照哪个字段搜索
 * @param originalArray     要搜索的数据源
 * @param searchText        搜索的文本
 * @param propertyName      按照字典中或者model中哪个字段搜索
 *
 */

+(NSMutableArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName;

@end
