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
    
    CAGradientLayer *gradienLayer;

}
@property (nonatomic, strong)  RCAnimatedImagesView *animatedImageView;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.showNavi=YES;
    [_animatedImageView startAnimating];

//    //友盟统计
//    [MobClick beginLogPageView:@"PageOne"];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    [_animatedImageView stopAnimating];
//    [MobClick endLogPageView:@"PageOne"];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)createData{

    isSave = YES;

}


- (void)viewDidUnload
{
    _animatedImageView=nil;
    
    [super viewDidUnload];
}

-(void)createUI{

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
    
    namefield.textAlignment=NSTextAlignmentLeft;
    [namefield setTintColor:[UIColor blackColor]];
    namefield.leftViewMode=UITextFieldViewModeAlways;
    [_animatedImageView addSubview:namefield];
    [namefield autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [namefield autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Icon withOffset:20];
    
    pwfield = [CustomField newAutoLayoutView]; ;
    pwfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    pwfield.textAlignment=NSTextAlignmentLeft;
    
    pwfield.leftViewMode=UITextFieldViewModeAlways;
    [_animatedImageView addSubview:pwfield];
    [pwfield addSubview:pwIcon];
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
    [_animatedImageView addSubview:loginbtn];

    [loginbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwfield withOffset:40];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-100];
     [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:TTScreenWith/2-100];
    [loginbtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*30/32];
    [loginbtn autoSetDimension:ALDimensionHeight toSize:35];
    [loginbtn addTarget:self action:@selector(pushloginVC) forControlEvents:UIControlEventTouchUpInside];
 
    
    bottomView = [UIView newAutoLayoutView];
    bottomView.backgroundColor = [colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1];
    [_animatedImageView addSubview:bottomView];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [bottomView autoSetDimension:ALDimensionHeight toSize:44];
    
    registbtn=[UIButton newAutoLayoutView];
    [registbtn setTitle:@"注册用户" forState:UIControlStateNormal];
    registbtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [_animatedImageView addSubview:forgetBtn];
    [registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_animatedImageView addSubview:registbtn];
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
    [_animatedImageView addSubview:forgetBtn];
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
    //创建渐变层
    gradienLayer = [CAGradientLayer layer];
    gradienLayer.frame = bottomLable.frame;
    //设置渐变层的颜色，颜色随机改变
    gradienLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    [bottomView.layer addSublayer:gradienLayer];
    
   
//利用定时器，快速切换渐变颜色，就有文字颜色变化的效果
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
#pragma -mark 定时器触发方法
- (void)textColorChange{
 
    gradienLayer.colors =  @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    

}

#pragma -mark 绘制随机颜色
- (UIColor *)randomColor{

    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    

}

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView
{
    return 3;
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
    
    PPRegistViewController *registVC = [PPRegistViewController shareInstance];
    registVC.showNavi = NO;
    [self.navigationController pushViewController:registVC animated:YES];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [namefield endEditing:YES];
    [pwfield endEditing:YES];
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




@end
