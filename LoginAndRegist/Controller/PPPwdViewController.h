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
@interface PPPwdViewController : PPBaseViewController<httpRequestDelegate,UITextFieldDelegate>

@property(nonatomic,copy)telPhone myBlock;
@property(nonatomic,strong) NSString    *userTelPhone;
- (void)retunTel:(telPhone)block;

@property (nonatomic, weak)UITextField *userText;
@property (nonatomic, weak)UILabel *userTextName;
@property (nonatomic, weak)UITextField *emailText;
@property (nonatomic, weak)UILabel *emailTextName;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UILabel *passwordTextName;
@property (nonatomic, weak)UIButton *loginBtn;
@property (nonatomic, assign) BOOL chang;
@end
