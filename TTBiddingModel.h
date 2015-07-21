//
//  TTBiddingModel.h
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "MTLModel.h"

@interface TTBiddingModel : MTLModel<MTLJSONSerializing>
//id           用户id
//title_name   标题
//project_id   项目编号
//project_name 项目名称
//project_situation 项目简介
//oppen_time   发布日期
//address      代理机构
//contact_name 项目负责人
//contact_info 联系方式
//url          详细网址

@property (nonatomic, copy)    NSString  *address;
@property (nonatomic, copy)    NSString  *contact_info;
@property (nonatomic, copy)    NSString  *contact_name;
@property (nonatomic, assign)    NSInteger  id;
@property (nonatomic, copy)    NSString  *oppen_time;
@property (nonatomic, copy)    NSString  *project_id;
@property (nonatomic, copy)    NSString  *project_name;
@property (nonatomic, copy)    NSString  *project_situation;
@property (nonatomic, copy)    NSString  *title_name;
@property (nonatomic, copy)    NSString  *url;

@end
