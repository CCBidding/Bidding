//
//  TTBiddingModel.h
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "MTLModel.h"

@interface TTBiddingModel : MTLModel<MTLJSONSerializing>
//id             编号
//bid_title      招标标题
//bid_condition  招标条件
//bid_survey     项目概况与招标范围
//bid_qua        投标人资格要求
//bid_obtain     招标文件的获取
//bid_reg        投标报名
//bid_submit     投标文件的递交
//bid_media      发布公告的媒介
//bid_contact    联系方式
//bid_other      其他事项
//org_name       招标机构
//org_putime     发布招标消息时间
//bid_url        详细地址
//ref_date       爬取存入时间

@property (nonatomic, assign)    NSInteger  id;
@property (nonatomic, copy)      NSString  *bid_title;
@property (nonatomic, copy)      NSString  *bid_condition;
@property (nonatomic, copy)      NSString  *bid_survey;
@property (nonatomic, copy)      NSString  *bid_qua;
@property (nonatomic, copy)      NSString  *bid_obtain;
@property (nonatomic, copy)      NSString  *bid_reg;
@property (nonatomic, copy)      NSString  *bid_submit;
@property (nonatomic, copy)      NSString  *bid_media;
@property (nonatomic, copy)      NSString  *bid_contact;
@property (nonatomic, copy)      NSString  *bid_other;
@property (nonatomic, copy)      NSString  *org_name;
@property (nonatomic, copy)      NSString  *org_putime;
@property (nonatomic, copy)      NSString  *bid_url;
@property (nonatomic, copy)      NSString  *ref_date;
@property (nonatomic, copy)      NSString  *bt_id;
@property (nonatomic, assign)      NSString  *pro_id;
@property (nonatomic, assign)      NSString  *qu_id;
@property (nonatomic, assign)      NSString  *status;

@end
