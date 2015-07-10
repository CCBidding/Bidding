//
//  config.h
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#ifndef ___config_h
#define ___config_h

#define TTScreenWith    [UIScreen mainScreen].bounds.size.width
#define TTScreenHeight  [UIScreen mainScreen].bounds.size.height
#define TTIOSUIDevice   [[[UIDevice currentDevice] systemVersion] floatValue]
#import "TTUserDefaultTool.h"
#import "CustomField.h"
#import "MBProgressHUD+Add.h"
#import "MBProgressHUD.h"
#import "CDRTranslucentSideBar.h"
#import "MBProgressHUD+Simple.h"

#define TTBaseurl    @"http://123.57.48.206:8080/GyBid"
#define TTLoginUrl   @"http://123.57.48.206:8080/GyBid/appLogin/login.do?type=onlinedo"
#define TTRegistUrl  @"http://123.57.48.206:8080/GyBid/appReg/regedit.do?type=onlinedo"
#define TTBiddingLsitUrl @"http://123.57.48.206:8080/GyBid/app/bilist.do?type=bilist"

#define TTUserid     @"user_id"
#define TTsessinid   @"session_id"
#define TTpassword   @"password"
#define TTusername   @"username"

#import "UIViewController+PPUser.h"
#import "colorTurn.h"
#import <QuartzCore/QuartzCore.h>
#endif
