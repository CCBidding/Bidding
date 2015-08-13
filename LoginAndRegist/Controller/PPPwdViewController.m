//
//  PPPwdViewController.m
//  招标
//
//  Created by ppan on 15/8/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPPwdViewController.h"

@interface PPPwdViewController ()
{

    UITextField *pwdText;
    UITextField *sureText;
   
    httpRequestViewController *httpController;

}
@end

@implementation PPPwdViewController

- (void)retunTel:(telPhone)block {

    self.myBlock = block;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   
}

- (void)createData {

    httpController = [[httpRequestViewController alloc]init];
    httpController.delegate = self;
}

- (void)createUI {

    NSLog(@"++%@",_userTelPhone);
    
    pwdText = [UITextField newAutoLayoutView];
    [self.view addSubview:pwdText];
    pwdText.placeholder = @"请输入密码";
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:80];
    [pwdText autoSetDimension:ALDimensionHeight toSize:40];
    pwdText.borderStyle = UITextBorderStyleRoundedRect;
    pwdText.backgroundColor = [colorTurn colorTurnWithRed:249 greed:35 blue:48 alpa:1];
    pwdText.textColor = [UIColor whiteColor];
    pwdText.secureTextEntry = YES;
    
    sureText = [UITextField newAutoLayoutView];
    [self.view addSubview:sureText];
    sureText.placeholder = @"请再次输入密码";
    [sureText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [sureText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdText withOffset:20];
    [sureText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:80];
    [sureText autoSetDimension:ALDimensionHeight toSize:40];
    sureText.borderStyle = UITextBorderStyleRoundedRect;
    sureText.backgroundColor = [colorTurn colorTurnWithRed:249 greed:35 blue:48 alpa:1];
    sureText.textColor = [UIColor whiteColor];
    sureText.secureTextEntry = YES;
    
    
    UIButton *resgistBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:resgistBtn];
    [resgistBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [resgistBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:100];
    [resgistBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
    [resgistBtn autoSetDimension:ALDimensionHeight toSize:40];
    [resgistBtn setTitle:@"注册" forState:UIControlStateNormal];
    [resgistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resgistBtn.backgroundColor = [colorTurn colorTurnWithRed:26 greed:117 blue:57 alpa:1];
    resgistBtn.layer.cornerRadius = 5;
    resgistBtn.layer.masksToBounds = YES;
    [resgistBtn addTarget:self action:@selector(resgistMsg) forControlEvents:UIControlEventTouchUpInside];


}
- (void) resgistMsg {

    if ([pwdText.text isEqualToString:sureText.text]) {
        NSString *baseUrl = @"http://114.215.97.235/appReg/regedit.do?type=onlinedo";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.userTelPhone forKey:@"cname"];
        [dic setObject:self.userTelPhone forKey:@"username"];
        [dic setObject:pwdText.text forKey:@"password"];
        [dic setObject:@"" forKey:@"pro_id"];
        [dic setObject:@"" forKey:@"qu_id"];
        [dic setObject:@"" forKey:@"duty_name"];
        [dic setObject:@"" forKey:@"dpro_id"];
        [dic setObject:@"" forKey:@"dqu_id"];
        [httpController onSearch:baseUrl withDic:dic];
    }else {
    
        [MBProgressHUD showError:@"两次密码不一致" toView:self.view];
    
    }
    
    

}

- (void)didReciveDataWithDic:(NSDictionary *)result andRequestUrl:(NSString *)url {



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
