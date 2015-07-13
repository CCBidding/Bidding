//
//  BiddingListViewController.h
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBiddingModel.h"
#import "ParentCellViewController.h"

@interface BiddingListViewController : ParentCellViewController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableview;
@property (nonatomic,strong) TTBiddingModel *biddingModel;


@end
