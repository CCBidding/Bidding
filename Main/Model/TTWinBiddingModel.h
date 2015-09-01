//
//  TTWinBiddingModel.h
//  招标
//
//  Created by mac chen on 15/7/21.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "MTLModel.h"

@interface TTWinBiddingModel : MTLModel<MTLJSONSerializing>
//id                       用户id
//widTitle                 中标标题
//bidOrg                   采购人
//proName                  项目名称
//xiangmuNum               项目编号
//xiangmuxulieNum          项目序列
//caigoufangshi            采购方式
//caigougonggaoriqijiMeiti 采购公告
//pingshenxini             评审信息
//oppenDate                定标日期
//widInfo                  中标信息
//other                    联系事项
//url                      详细网址

//putime                   发布中标时间

@property (nonatomic, assign)   NSInteger id;
@property (nonatomic, copy)     NSString *widTitle;
@property (nonatomic, copy)     NSString *bidOrg;
@property (nonatomic, copy)     NSString *proName;
//@property (nonatomic, copy)     NSString *xiangmuNum;
//@property (nonatomic, copy)     NSString *xiangmuxulieNum;
//@property (nonatomic, copy)     NSString *caigoufangshi;
//@property (nonatomic, copy)     NSString *caigougonggaoriqijiMeiti;
//@property (nonatomic, copy)     NSString *pingshenxinxi;
@property (nonatomic, copy)     NSString *oppenDate;
@property (nonatomic, copy)     NSString *widInfo;
@property (nonatomic, copy)     NSString *other;
@property (nonatomic, copy)     NSString *url;
@property (nonatomic, assign)   NSInteger status;
@property (nonatomic, copy)     NSString  *putime;




@end
