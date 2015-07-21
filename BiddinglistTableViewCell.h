//
//  BiddinglistTableViewCell.h
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBiddingModel.h"
#import "TTWinBiddingModel.h"

@interface BiddinglistTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel        *titleLab;    //标题
@property (nonatomic, strong) UILabel        *infoLab;     //主要信息
@property (nonatomic, strong) UILabel        *addressLab;  //单位信息
@property (nonatomic, copy)   TTBiddingModel *biddingModel;  //招标数据
@property (nonatomic, copy)   TTWinBiddingModel *winBiddingModel; //中标数据
@property (nonatomic, strong) UIView         *backgroundview; //底部视图
@property (nonatomic, strong) UILabel        *timeLab;     //发布时间

@end
