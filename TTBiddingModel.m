//
//  TTBiddingModel.m
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTBiddingModel.h"

@implementation TTBiddingModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"id":@"id",
             @"title_name":@"title_name",
             @"project_id":@"project_id",
             @"project_name":@"project_name",
             @"project_situation":@"project_situation",
             @"oppen_time":@"oppen_time",
             @"address":@"address",
             @"contact_name":@"contact_name",
             @"contact_info":@"contact_info",
             @"url":@"url"};
}
@end
