//
//  HomeViewController.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "HomeViewController.h"
#import "RegistViewController.h"
#import "BiddingListViewController.h"

@interface HomeViewController ()
{
    UIImageView *backgroundImage;//背景图片
    CustomField *namefield;
    CustomField *pwfield;
    UIImageView *Icon;      //开始界面头像
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
    
    Icon=[UIImageView newAutoLayoutView];
    Icon.image=[UIImage imageNamed:@"Icon"];
     Icon.layer.cornerRadius=50;
    [Icon.layer setMasksToBounds:YES];
    [self.view addSubview:Icon];
    [Icon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
    [Icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-50];
    [Icon autoSetDimension:ALDimensionHeight toSize:100];
    [Icon autoSetDimension:ALDimensionWidth toSize:100];
    
    
    
    namefield=[CustomField newAutoLayoutView];
    namefield.placeholder=@"username";
    namefield.textColor=[UIColor whiteColor];
    namefield.textAlignment=NSTextAlignmentCenter;
    accIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account"]];
    //textfield左侧添加图片
    namefield.leftView=accIcon;
    namefield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:namefield];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:300];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    pwfield=[CustomField newAutoLayoutView];
    pwfield.placeholder=@"password";
    pwfield.textColor=[UIColor whiteColor];
    pwfield.textAlignment=NSTextAlignmentCenter;
    pwIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    pwfield.leftView=pwIcon;
    pwfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:pwfield];
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
     [self.view endEditing:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFHTTPRequestOperation *op = [manager POST:TTLoginUrl parameters:@{@"username":namefield.text,@"password":pwfield.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
            [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTsessinid];
            [TTUserDefaultTool setObject:namefield.text forKey:TTusername];
            [TTUserDefaultTool setObject:pwfield.text   forKey:TTpassword];
            [MBProgressHUD showMessageThenHide:@"已成功登录" toView:self.view];
            BiddingListViewController *biddingVC;
            if (!biddingVC) {
                biddingVC=[[BiddingListViewController alloc]init];
                    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:biddingVC];
                    [self presentViewController:nav animated:YES completion:nil];
            }
        }
        else{
           [MBProgressHUD showMessageThenHide:@"用户名或密码错误，请重试" toView:self.view];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    [op start];
 

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
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
