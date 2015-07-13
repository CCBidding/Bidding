//
//  MenuViewController.h
//  招标
//
//  Created by mac chen on 15/7/6.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *myTableView;
@end
