//
//  HomeViewController.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "HomeViewController.h"
#import "RegistViewController.h"

@interface HomeViewController ()
{
    UIImageView *backgroundImage;//背景图片
    UITextField *namefield;
    UITextField *pwfield;
    UIButton    *loginbtn;
    UIButton    *registbtn;
    UIImageView *accIcon;
    UIImageView *pwIcon;

}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self registerForKeyboardNotifications];
}


-(void)creatUI{
    backgroundImage=[UIImageView newAutoLayoutView];
    UIImage *img=[[UIImage alloc]init];
   backgroundImage.image= [img getBlurImage:[UIImage imageNamed:@"backImage2"]];
    backgroundImage.userInteractionEnabled=YES;
    [backgroundImage bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
      [self.view addSubview:backgroundImage];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [backgroundImage  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    namefield=[UITextField newAutoLayoutView];
    namefield.placeholder=@"username";
    namefield.textColor=[UIColor whiteColor];
    namefield.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:namefield];
    accIcon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    accIcon.image=[UIImage imageNamed:@"account"];
    [namefield addSubview:accIcon];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:300];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    pwfield=[UITextField newAutoLayoutView];
    pwfield.placeholder=@"password";
    pwfield.textColor=[UIColor whiteColor];
    pwfield.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:pwfield];
    pwIcon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    pwIcon.image=[UIImage imageNamed:@"password"];
    [pwfield addSubview:pwIcon];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:350];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    loginbtn=[UIButton newAutoLayoutView];
    [loginbtn setTitle:@"login" forState:UIControlStateNormal];
    [self.view addSubview:loginbtn];
    loginbtn.backgroundColor=[UIColor colorWithRed:0 green:245/255.0 blue:255/255.0 alpha:1];
    loginbtn.layer.cornerRadius=5;
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:400];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [loginbtn addTarget:self action:@selector(pushloginVC) forControlEvents:UIControlEventTouchUpInside];
    
    registbtn=[UIButton newAutoLayoutView];
    [registbtn setTitle:@"regist" forState:UIControlStateNormal];
    [self.view addSubview:registbtn];
    registbtn.backgroundColor=[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    registbtn.layer.cornerRadius=5;
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:450];
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [registbtn addTarget:self action:@selector(pushregistVC) forControlEvents:UIControlEventTouchUpInside];

}

-(void)pushloginVC{
 

}

-(void)pushregistVC{
    RegistViewController *registVC;
    if (!registVC) {
        registVC=[[RegistViewController alloc]init];
    }
    [self presentViewController:registVC animated:YES completion:nil];

}

#pragma mark - 获取键盘高度

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.view.frame=CGRectMake(0, -keyboardSize.height, TTScreenWith, TTScreenHeight);

}
- (void) keyboardWasHidden:(NSNotification *) notif {
     self.view.frame=CGRectMake(0, 0, TTScreenWith, TTScreenHeight);
 
}


@end
