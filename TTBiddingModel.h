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
//title_name   标题名
//project_id   项目id
//project_name 项目名
//project_situation 项目情况
//oppen_time   打开时间
//address      地址
//contact_name 招标人名字
//contact_info 招标人联系方式
//url          招标网站

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
