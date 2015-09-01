//
//  PPPwdViewController.m
//  招标
//
//  Created by ppan on 15/8/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPPwdViewController.h"
#import "InputText.h"
@interface PPPwdViewController ()
{

 
   
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

    CGFloat centerX = self.view.width * 0.5;
    InputText *inputText = [[InputText alloc] init];
    CGFloat userY = 150;
    UITextField *userText = [inputText setupWithIcon:nil textY:userY centerX:centerX point:nil];
    userText.delegate = self;
    self.userText = userText;
    [userText setReturnKeyType:UIReturnKeyNext];
    [userText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userText];
    
    UILabel *userTextName = [self setupTextName:@"单位名称" frame:userText.frame];
    self.userTextName = userTextName;
    [self.view addSubview:userTextName];
    
    CGFloat emailY = CGRectGetMaxY(userText.frame) + 30;
    UITextField *emailText = [inputText setupWithIcon:nil textY:emailY centerX:centerX point:nil];
    emailText.keyboardType = UIKeyboardTypeEmailAddress;
    [emailText setReturnKeyType:UIReturnKeyNext];
    emailText.delegate = self;
    emailText.secureTextEntry = YES;
    self.emailText = emailText;
    [emailText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:emailText];
    
    UILabel *emailTextName = [self setupTextName:@"密码" frame:emailText.frame];
    self.emailTextName = emailTextName;
    [self.view addSubview:emailTextName];
    
    CGFloat passwordY = CGRectGetMaxY(emailText.frame) + 30;
    UITextField *passwordText = [inputText setupWithIcon:nil textY:passwordY centerX:centerX point:nil];
    [passwordText setReturnKeyType:UIReturnKeyDone];
    [passwordText setSecureTextEntry:YES];
    passwordText.delegate = self;
    self.passwordText = passwordText;
    [passwordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordText];
    UILabel *passwordTextName = [self setupTextName:@"再输入密码" frame:passwordText.frame];
    self.passwordTextName = passwordTextName;
    [self.view addSubview:passwordTextName];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.width = 200;
    loginBtn.height = 30;
    loginBtn.centerX = self.view.width * 0.5;
    loginBtn.y = CGRectGetMaxY(passwordText.frame) + 80;
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor orangeColor]];
    loginBtn.enabled = NO;
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(resgistMsg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];



}

- (UILabel *)setupTextName:(NSString *)textName frame:(CGRect)frame
{
    UILabel *textNameLabel = [[UILabel alloc] init];
    textNameLabel.text = textName;
    textNameLabel.font = [UIFont systemFontOfSize:16];
    textNameLabel.textColor = [UIColor grayColor];
    textNameLabel.frame = frame;
    return textNameLabel;
}

- (void) resgistMsg {

    if ([self.emailText.text isEqualToString:self.passwordText.text]) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.userTelPhone forKey:@"username"];
        [dic setObject:self.emailText.text forKey:@"password"];
        [httpController onSearch:TTRegistUrl withDic:dic];
        [MBProgressHUD showMessag:@"正在注册" toView:self.view];
        
    }else {
    
        [MBProgressHUD showError:@"两次密码不一致" toView:self.view];
    
    }
    
    

}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.userText) {
        [self diminishTextName:self.userTextName];
        [self restoreTextName:self.emailTextName textField:self.emailText];
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
    } else if (textField == self.emailText) {
        [self diminishTextName:self.emailTextName];
        [self restoreTextName:self.userTextName textField:self.userText];
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
    } else if (textField == self.passwordText) {
        [self diminishTextName:self.passwordTextName];
        [self restoreTextName:self.userTextName textField:self.userText];
        [self restoreTextName:self.emailTextName textField:self.emailText];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userText) {
        return [self.emailText becomeFirstResponder];
    } else if (textField == self.emailText){
        return [self.passwordText becomeFirstResponder];
    } else {
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
        return [self.passwordText resignFirstResponder];
    }
}
- (void)diminishTextName:(UILabel *)label
{
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, -16);
        label.font = [UIFont systemFontOfSize:9];
    }];
}
- (void)restoreTextName:(UILabel *)label textField:(UITextField *)textFieled
{
    [self textFieldTextChange:textFieled];
    if (self.chang) {
        [UIView animateWithDuration:0.5 animations:^{
            label.transform = CGAffineTransformIdentity;
            label.font = [UIFont systemFontOfSize:16];
        }];
    }
}
- (void)textFieldTextChange:(UITextField *)textField
{
    if (textField.text.length != 0) {
        self.chang = NO;
    } else {
        self.chang = YES;
    }
}
- (void)textFieldDidChange
{
    if (self.userText.text.length != 0 && self.emailText.text.length != 0 && self.passwordText.text.length != 0) {
        self.loginBtn.enabled = YES;
    } else {
        self.loginBtn.enabled = NO;
    }
}
#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self restoreTextName:self.userTextName textField:self.userText];
    [self restoreTextName:self.emailTextName textField:self.emailText];
    [self restoreTextName:self.passwordTextName textField:self.passwordText];
}

- (void)didReciveDataWithDic:(NSDictionary *)result andRequestUrl:(NSString *)url {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *code = result[@"code"];
    int codeInt = code.intValue;
    switch (codeInt) {
        case 200:{
             NSArray *dic = result[@"datas"];
            if (![dic[0][@"sessionid"] isEqualToString:@"userexist"]) {
                
                [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else {
                
                [MBProgressHUD showError:@"用户名已存在" toView:self.view];
            }
        
        }
            
            break;
        case 404:{
        
             [MBProgressHUD showSuccess:@"字段不符合要求" toView:self.view];
        }
            break;
            
        case 500:{
        
            [MBProgressHUD showSuccess:@"服务器异常，请稍后重试" toView:self.view];
        }
            break;
        default:
            break;
    }
   
   

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
