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
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.showNavi=NO;

//    //友盟统计
//    [MobClick beginLogPageView:@"PageOne"];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
//    [MobClick endLogPageView:@"PageOne"];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)createData{

    isSave = YES;

}
-(void)createUI{
//    backgroundImage=[UIImageView newAutoLayoutView];
//    UIImage *img=[[UIImage alloc]init];
//   //backgroundImage.image= [img getBlurImage:[UIImage imageNamed:@"backImage2"]];
//    backgroundImage.userInteractionEnabled=YES;
//    [backgroundImage bk_whenTapped:^{
//        [self.view endEditing:YES];
//    }];
//      [self.view addSubview:backgroundImage];
//    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
//    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//    [backgroundImage  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    bgIconView = [UIView newAutoLayoutView];
    bgIconView.backgroundColor = [colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1];
    [bgIconView.layer setMasksToBounds:YES];
    [self.view addSubview:bgIconView];
    [bgIconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bgIconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [bgIconView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [bgIconView autoSetDimension:ALDimensionHeight toSize:TTScreenHeight*1/2];
    
    
    Icon=[UIImageView newAutoLayoutView];
    //[Icon setAutoresizingMask:UIViewAutoresizingNone];
    Icon.image=[UIImage imageNamed:@"31"];
    Icon.layer.cornerRadius = 50;
    [Icon.layer setMasksToBounds:YES];
    [self.view addSubview:Icon];
    [Icon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [Icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-50];
    [Icon autoSetDimension:ALDimensionHeight toSize:100];
    [Icon autoSetDimension:ALDimensionWidth toSize:100];
    
    
    
    namefield=[CustomField newAutoLayoutView];
    namefield.placeholder=@"用户名";
    
    namefield.textAlignment=NSTextAlignmentLeft;
    [namefield setTintColor:[UIColor blackColor]];
    accIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
    //textfield左侧添加图片
    namefield.leftView=accIcon;
    namefield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:namefield];
    [namefield autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [namefield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [namefield autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bgIconView withOffset:20];
    
    pwfield = [CustomField newAutoLayoutView];
    pwfield.placeholder=@"密码";
    
    pwfield.textAlignment=NSTextAlignmentLeft;
    pwIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3"]];
    pwfield.leftView=pwIcon;
    
    pwfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:pwfield];
    [pwfield addSubview:pwIcon];
    [pwfield autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [pwfield autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:namefield withOffset:20];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [pwfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    remenberBtn = [UIButton newAutoLayoutView];
   
    [remenberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    remenberBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [remenberBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    [remenberBtn setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    
    [self.view addSubview:remenberBtn];
    [remenberBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwfield withOffset:15];
    [remenberBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [remenberBtn autoSetDimension:ALDimensionWidth toSize: TTScreenWith*10/32];
    [remenberBtn autoSetDimension:ALDimensionHeight toSize:30];
    [remenberBtn bk_whenTapped:^{
        //记住密码要做的事
        isSave = !isSave;
        if (isSave) {
            [remenberBtn setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        }else
            [remenberBtn setImage:[UIImage imageNamed:@"25"] forState:UIControlStateNormal];
        
    }];
    
    forgetBtn  = [UIButton newAutoLayoutView];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.view addSubview:forgetBtn];
    [forgetBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwfield withOffset:15];
    [forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [forgetBtn autoSetDimension:ALDimensionHeight toSize:30];
    [forgetBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [forgetBtn bk_whenTapped:^{
       //忘记密码
        
    }];
    
    loginbtn=[UIButton newAutoLayoutView];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"29"] forState:UIControlStateNormal];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"26"] forState:UIControlStateHighlighted];
    [self.view addSubview:loginbtn];

    loginbtn.layer.cornerRadius=5;
    [loginbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:remenberBtn withOffset:20];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-100];
    [loginbtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [loginbtn autoSetDimension:ALDimensionHeight toSize:35];
    [loginbtn addTarget:self action:@selector(pushloginVC) forControlEvents:UIControlEventTouchUpInside];
    
    registbtn=[UIButton newAutoLayoutView];
    [registbtn setBackgroundImage:[UIImage imageNamed:@"28"] forState:UIControlStateNormal];
    [registbtn setBackgroundImage:[UIImage imageNamed:@"27"] forState:UIControlStateHighlighted];
    [self.view addSubview:registbtn];
    registbtn.layer.cornerRadius=5;
    [registbtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:remenberBtn withOffset:20];
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:TTScreenWith/2-100];
    [registbtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [registbtn  autoSetDimension:ALDimensionHeight toSize:35];
    [registbtn addTarget:self action:@selector(pushregistVC) forControlEvents:UIControlEventTouchUpInside];

//    centerLabel = [UILabel newAutoLayoutView];
//    centerLabel.text = @"or";
//    centerLabel.textAlignment = NSTextAlignmentCenter;
//    centerLabel.backgroundColor = [UIColor whiteColor];
//    [centerLabel setAutoresizesSubviews:YES];
//    [self.view addSubview:centerLabel];
//    [centerLabel setUserInteractionEnabled:YES];
//    [centerLabel autoSetDimension:ALDimensionWidth toSize:35];
//    [centerLabel autoSetDimension:ALDimensionHeight toSize:35];
//    centerLabel.layer.borderWidth = 1;
//    centerLabel.layer.borderColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1].CGColor;
//    centerLabel.layer.cornerRadius = 17.5;
//    [centerLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:400];
//    [centerLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-17.5];
    
    centerView = [UIView newAutoLayoutView];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    [centerView autoSetDimension:ALDimensionWidth toSize:35];
    [centerView autoSetDimension:ALDimensionHeight toSize:35];
    centerView.layer.borderWidth = 1;
    centerView.layer.borderColor = (__bridge CGColorRef)([colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1]);
    centerView.layer.cornerRadius = 17.5;
    [centerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:remenberBtn withOffset:20];
    [centerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith/2-17.5];
    
    
    bottomView = [UIView newAutoLayoutView];
    bottomView.backgroundColor = [colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1];
    [self.view addSubview:bottomView];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [bottomView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [bottomView autoSetDimension:ALDimensionHeight toSize:44];
    
    
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
    gradienLayer.mask = bottomLable.layer;
    bottomLable.frame = gradienLayer.frame;
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
    PPRegistViewController *registVC;
    if (!registVC) {
        registVC = [[PPRegistViewController alloc]init];
       
    }
    registVC.haveBack=YES;
    registVC.showNavi = YES;
    registVC.isShowModal=YES;
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:registVC];
    [self presentViewController:nav animated:YES completion:nil];

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
    NSDictionary *info  = [notif userInfo];
    NSValue *value      = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.view.frame     = CGRectMake(0, -keyboardSize.height, TTScreenWith, TTScreenHeight);

}
- (void) keyboardWasHidden:(NSNotification *) notif {
    self.view.frame = CGRectMake(0, 0, TTScreenWith, TTScreenHeight);
 
}



@end
