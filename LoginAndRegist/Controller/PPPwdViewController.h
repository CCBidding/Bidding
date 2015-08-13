//
//  PPPwdViewController.h
//  招标
//
//  Created by ppan on 15/8/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPBaseViewController.h"
#import "httpRequestViewController.h"
typedef void(^telPhone)(NSString *tel);
@interface PPPwdViewController : PPBaseViewController<httpRequestDelegate>

@property(nonatomic,copy)telPhone myBlock;
@property(nonatomic,strong) NSString    *userTelPhone;
- (void)retunTel:(telPhone)block;
@end
