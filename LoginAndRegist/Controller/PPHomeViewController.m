//
//  PPHomeViewController.m
//  招标
//
//  Created by ppan on 15/8/13.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPHomeViewController.h"
#import "TTRootViewController.h"
#import "PPRegistTTViewController.h"
@interface PPHomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@end

@implementation PPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
     [self registerForKeyboardNotifications];
    self.navigationController.navigationBarHidden = YES;

}
- (void)createUI {

    self.bgView.backgroundColor = [colorTurn colorTurnWithRed:134 greed:20 blue:23 alpa:1];
    self.bottomView.backgroundColor = [colorTurn colorTurnWithRed:134 greed:20 blue:23 alpa:1];
    self.logoView.layer.cornerRadius = 40;
    self.logoView.layer.masksToBounds = YES;
    self.pwd.secureTextEntry = YES;

}

- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    [MBProgressHUD showLoading:@"正在登录" toView:self.view];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFHTTPRequestOperation *op = [manager POST:TTLoginUrl parameters:@{@"username":self.userName.text,@"password":self.pwd.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
            [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTsessinid];
            [TTUserDefaultTool setObject:self.userName.text forKey:TTusername];
            [TTUserDefaultTool setObject:self.pwd.text   forKey:TTpassword];
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
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
- (IBAction)resgist:(UIButton *)sender {
    PPRegistTTViewController *registVC = [[PPRegistTTViewController alloc]init];
    registVC.showNavi = YES;
    registVC.haveBack = NO;
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.userName endEditing:YES];
    [self.pwd endEditing:YES];

}

#pragma mark - 获取键盘高度

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -150, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:nil];
    
}
- (void) keyboardWasHidden:(NSNotification *) notif {
    self.view.frame = CGRectMake(0, 0, TTScreenWith, TTScreenHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
