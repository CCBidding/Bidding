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
#define TTColor(r,g,b,alp)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alp]
#import "TTUserDefaultTool.h"
#import "CustomField.h"
#import "MBProgressHUD+Add.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Simple.h"
#import "PPBaseViewController.h"
#import "SDRefresh.h"

#define TTBaseurl    @"http://123.57.48.206:8080/GyBid"
#define TTLoginUrl   @"http://123.57.48.206:8080/GyBid/appLogin/login.do?type=onlinedo"
#define TTRegistUrl  @"http://123.57.48.206:8080/GyBid/appReg/regedit.do?type=onlinedo"
#define TTBiddingLsitUrl @"http://123.57.48.206:8080/GyBid/app/bilist.do?type=bilist"
#define TTBidWinlistUrl  @"http://123.57.48.206:8080/GyBid/app/wilist.do?type=wilist"
#define TTgetCategorylistUrl @"http://123.57.48.206:8080/GyBid/appReg/comtype.do?type=proty"
#define TTGetComtypeURL  @"http://123.57.48.206:8080/GyBid/appReg/comtype.do?type=quaty" //获取资质接口
#define TTGetGradeURL     @"http://123.57.48.206:8080/GyBid/appReg/findgrade.do" //获取等级接口
#define TTUserid     @"user_id"
#define TTsessinid   @"session_id"
#define TTpassword   @"password"
#define TTusername   @"username"
#define TTcateGory   @"cateGory"
//通知的时间
#define TTEnterBackOrTerminateTime @"notificationTime"

#import "UIViewController+PPUser.h"
#import "colorTurn.h"
#import <QuartzCore/QuartzCore.h>
#import "PPRegistViewController.h"
#import "PPRegistTableViewCell.h"
#import "DropDownListView.h"
#import "IGLDropDownMenu.h"
#import "TYGSelectMenu.h"
#import "HomeViewController.h"
#import "PPAboutUsViewController.h"
#import "PPChooseInfoViewController.h"
#import "PinyinHelper.h"
#import "PPGuideUserView.h"
#import "TTBaseWebViewController.h"
#import "PPGadeViewController.h"
#import "PPSelectedViewController.h"
#endif
