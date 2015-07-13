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
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UILabel     *infoLab;
@property (nonatomic, copy)   TTBiddingModel *biddingModel;

@end
