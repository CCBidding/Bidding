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
//title_name               采购标题
//caigourenName            采购人
//xiangmuName              项目名称
//xiangmuNum               项目编号
//xiangmuxulieNum          项目序列
//caigoufangshi            采购方式
//caigougonggaoriqijiMeiti 采购公告
//pingshenxini             评审信息
//dingbiaoriqi             定标日期
//dingbiaoriqi             中标信息
//dingbiaoriqi             联系事项
//dingbiaoriqi             详细网址



@property (nonatomic, assign)   NSInteger id;
@property (nonatomic, copy)     NSString *title_name;
@property (nonatomic, copy)     NSString *caigourenName;
@property (nonatomic, copy)     NSString *xiangmuName;
@property (nonatomic, copy)     NSString *xiangmuNum;
@property (nonatomic, copy)     NSString *xiangmuxulieNum;
@property (nonatomic, copy)     NSString *caigoufangshi;
@property (nonatomic, copy)     NSString *caigougonggaoriqijiMeiti;
@property (nonatomic, copy)     NSString *pingshenxinxi;
@property (nonatomic, copy)     NSString *dingbiaoriqi;
@property (nonatomic, copy)     NSString *zhongbiaoxinxi;
@property (nonatomic, copy)     NSString *lianxishixiang;
@property (nonatomic, copy)     NSString *url;




@end
