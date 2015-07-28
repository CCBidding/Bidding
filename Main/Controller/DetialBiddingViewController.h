//
//  DetialBiddingViewController.h
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBiddingModel.h"
#import "TTWinBiddingModel.h"

typedef NS_ENUM(NSInteger, detailbidType)
{
    detailbidTypeBidding,
    detailbidTypeWinBidding
};

@interface DetialBiddingViewController : PPBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableview;
@property (nonatomic, copy)   TTBiddingModel *biddingModel;
@property (nonatomic, copy)   TTWinBiddingModel *winBiddingModel;
@property (nonatomic, assign) detailbidType  detailBidType;   //详情类型


@end
