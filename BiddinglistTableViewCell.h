//
//  BiddinglistTableViewCell.h
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBiddingModel.h"

@interface BiddinglistTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel        *titleLab;    //标题
@property (nonatomic, strong) UILabel        *infoLab;     //主要信息
@property (nonatomic, strong) UILabel        *addressLab;  //单位信息
@property (nonatomic, copy  ) TTBiddingModel *biddingModel;
@property (nonatomic, strong) UILabel        *timeLab;     //发布时间

@end
