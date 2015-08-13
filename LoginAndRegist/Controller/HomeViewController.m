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
#import "TTRootViewController.h"
#import "PPRegistTTViewController.h"
@interface HomeViewController ()
{
    UIImageView *backgroundImage;//背景图片
    UIView      *bgIconView; //icon的背景
    CustomField *namefield;
    CustomField *pwfield;
    UIImageView *Icon;      //开始界面头像
    UIButton    *loginbtn;
    UIButton    *registbtn;
    UIImageView *accIcon;
    UIImageView *pwIcon;
    UILabel     *centerLabel;
    UIView      *centerView;
    UIView      *bottomView;
    UILabel     *bottomLable;
    UIButton    *remenberBtn; //记住密码
    UIButton    *forgetBtn;   //忘记密码
    BOOL         isSave;     //是否记住密码
    BOOL         isShowNav;  //是否显示导航
    CAGradientLayer *gradienLayer;

}
@property (nonatomic, strong)  RCAnimatedImagesView *animatedImageView;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [_animatedImageView startAnimating];

    self.navigationController.navigationBarHidden = YES;
//    //友盟统计
//    [MobClick beginLogPageView:@"PageOne"];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
 [_animatedImageView stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)createData{

    isSave = YES;
    isShowNav = YES;

}




-(void)createUI{


    self.title = @"用户登录";
     self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1];
    _animatedImageView = [RCAnimatedImagesView newAutoLayoutView];
    _animatedImageView.delegate = self;
    [self.view addSubview:_animatedImageView];
    [_animatedImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    Icon=[UIImageView newAutoLayoutView];
    //[Icon setAutoresizingMask:UIViewAutoresizingNone];
    Icon.image=[UIImage imageNamed:@"logo"];
    Icon.layer.cornerRadius = TTScreenWith * 80/640;
    [self.view addSubview:Icon];
    [Icon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [Icon autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [Icon autoSetDimension:ALDimensionHeight toSize:TTScreenWith * 80/320];
    [Icon autoSetDimension:ALDimensionWidth toSize:TTScreenWith * 80/320];
      [Icon.layer setMasksToBounds:YES];
    
    
    
    namefield=[CustomField newAutoLayoutView];
    namefield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    namefield.textColor = [UIColor whiteColor];
    if (namefield.text.length > 0) {
        [namefield setFont:[UIFont fontWithName:@"Heiti SC" size:25.0]];
    }
    namefield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    namefield.textAlignment=NSTextAlignmentLeft;
    [namefield setTintColor:[UIColor blackColor]];
    namefield.leftViewMode=UITextFieldViewModeAlways;
    namefield.delegate = self;
    [self.view addSubview:namefield];
    [namefield autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [namefield autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Icon withOffset:20];
    
    pwfield = [CustomField newAutoLayoutView]; ;
    pwfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    pwfield.secureTextEntry = YES;
    pwfield.textAlignment=NSTextAlignmentLeft;
    pwfield.textColor = [UIColor whiteColor];
    if (pwfield.text.length > 0) {
        [pwfield setFont:[UIFont fontWithName:@"Heiti SC" size:25.0]];
    }
    pwfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pwfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:pwfield];
    [pwfield addSubview:pwIcon];
    pwfield.delegate = self;
    [pwfield autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [pwfield autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:namefield withOffset:20];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    
    loginbtn = [UIButton newAutoLayoutView];
    UIColor *color =TTColor(155, 36, 32, 1);
    [loginbtn setBackgroundColor:color];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbtn.layer.cornerRadius = 5;
    loginbtn.layer.masksToBounds = YES ;
    [self.view addSubview:loginbtn];

    [loginbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwfield withOffset:40];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-100];
     [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:TTScreenWith/2-100];
    [loginbtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*30/32];
    [loginbtn autoSetDimension:ALDimensionHeight toSize:35];
    [loginbtn addTarget:self action:@selector(pushloginVC) forControlEvents:UIControlEventTouchUpInside];
 
    
    bottomView = [UIView newAutoLayoutView];
    bottomView.backgroundColor = [colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1];
    [self.view addSubview:bottomView];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [bottomView autoSetDimension:ALDimensionHeight toSize:44];
    
    registbtn=[UIButton newAutoLayoutView];
    [registbtn setTitle:@"注册用户" forState:UIControlStateNormal];
    registbtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.view addSubview:forgetBtn];
    [registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registbtn];
    registbtn.layer.cornerRadius=5;
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [registbtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [registbtn autoSetDimension:ALDimensionHeight toSize:30];
    [registbtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:bottomView withOffset:0];
    [registbtn addTarget:self action:@selector(pushregistVC) forControlEvents:UIControlEventTouchUpInside];
    
    forgetBtn  = [UIButton newAutoLayoutView];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.view addSubview:forgetBtn];
    [forgetBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:bottomView withOffset:0];
    [forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [forgetBtn autoSetDimension:ALDimensionHeight toSize:30];
    [forgetBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [forgetBtn bk_whenTapped:^{
        //忘记密码
        
    }];

    
    bottomLable = [UILabel newAutoLayoutView];
    bottomLable.text = @"贵阳招标投标行业协会";
    bottomLable.textColor = [UIColor whiteColor];
    bottomLable.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:bottomLable];
    [bottomLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [bottomLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bottomLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [bottomLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if (isShowNav) {
        
        self.navigationController.navigationBarHidden = NO;
    }else{
        
        self.navigationController.navigationBarHidden = YES;
    }
   isShowNav = !isShowNav;

}
- (void)textFieldDidEndEditing:(UITextField *)textField {

    isShowNav = !isShowNav;
    
    [self.view reloadInputViews];
}

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView
{
    return 2;
}

- (UIImage*)animatedImagesView:(RCAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:@"AnimatedImage"];
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
                TTRootViewController *rootVC=[[TTRootViewController alloc]init];
                self.view.window.rootViewController=rootVC;

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
    
    PPRegistTTViewController *registVC = [[PPRegistTTViewController alloc]init];
    registVC.showNavi = YES;
    registVC.haveBack = NO;
    [self.navigationController pushViewController:registVC animated:YES];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [namefield endEditing:YES];
    [pwfield endEditing:YES];
   
    self.navigationController.navigationBarHidden = YES;
    if (![loginbtn isFirstResponder]||![registbtn isFirstResponder]) {
        [self.view endEditing:YES];
    }

}

#pragma mark - 获取键盘高度

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -50, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:nil];

}
- (void) keyboardWasHidden:(NSNotification *) notif {
    self.view.frame = CGRectMake(0, 0, TTScreenWith, TTScreenHeight);
 
}
- (void)viewDidUnload
{
    _animatedImageView = nil;
    
    [super viewDidUnload];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}



@end
