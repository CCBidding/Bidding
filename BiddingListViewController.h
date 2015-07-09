//
//  BiddingListViewController.h
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiddingListViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *Mytableview;


@end
