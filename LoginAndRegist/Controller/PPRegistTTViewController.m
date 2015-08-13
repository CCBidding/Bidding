//
//  PPRegistTTViewController.m
//  
//
//  Created by ppan on 15/8/10.
//
//

#import "PPRegistTTViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "PPPwdViewController.h"
@interface PPRegistTTViewController()
{

    UITextField     *telPhoneText;
    UITextField     *msgText;
    UIButton        *sendMsgBtn; //发送短信
    NSTimer         *timer;       //定时器
    int             start;
    UILabel         *firstLabel;
    UILabel         *secondLabel;
    UILabel         *thirdLabel;
    UILabel         *fouthLabel;
    UIView     *labelView;  //用来存放label
    UIButton        *registBtn;
    NSString        *info;   //生成的随机数
}
@end

@implementation PPRegistTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createData {

    start = 60;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)createUI {

    self.title = @"注册";
    self.haveBack = NO;
    telPhoneText = [UITextField newAutoLayoutView];
    [self.view addSubview:telPhoneText];
    telPhoneText.placeholder = @"请输入手机号码";
    telPhoneText.tintColor = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:0.5];;
    telPhoneText.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    telPhoneText.textAlignment = NSTextAlignmentCenter;
    telPhoneText.borderStyle = UITextBorderStyleRoundedRect;
    [telPhoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [telPhoneText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [telPhoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [telPhoneText autoSetDimension:ALDimensionHeight toSize:40];
    telPhoneText.keyboardType = UIKeyboardTypePhonePad;
    
    labelView = [UIView newAutoLayoutView];
    [self.view addSubview:labelView];
    [labelView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:telPhoneText withOffset:20];
    [labelView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [labelView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
    [labelView autoSetDimension:ALDimensionHeight toSize:40];
    
    labelView.userInteractionEnabled = YES;
    firstLabel = [UILabel newAutoLayoutView];
    [labelView addSubview:firstLabel];

    
    msgText = [UITextField newAutoLayoutView];
    [self.view addSubview:msgText];
    msgText.placeholder = @"请输入验证码";
    msgText.tintColor = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:1];
    msgText.textAlignment = NSTextAlignmentCenter;
    msgText.borderStyle = UITextBorderStyleRoundedRect;
    [msgText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:telPhoneText withOffset:20];
    [msgText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [msgText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
    [msgText autoSetDimension:ALDimensionHeight toSize:40];
    msgText.delegate = self;
    msgText.textColor = [UIColor whiteColor];
   
    
    [firstLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [firstLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [firstLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [firstLabel autoSetDimension:ALDimensionWidth toSize:40];
    firstLabel.layer.cornerRadius = 20;
    firstLabel.layer.masksToBounds = YES;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textColor = [UIColor whiteColor];

    
    secondLabel = [UILabel newAutoLayoutView];
    [labelView addSubview:secondLabel];
    [secondLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [secondLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:firstLabel withOffset:5];
    [secondLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [secondLabel autoSetDimension:ALDimensionWidth toSize:40];
    secondLabel.layer.cornerRadius = 20;
    secondLabel.layer.masksToBounds = YES;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor whiteColor];
    
    thirdLabel = [UILabel newAutoLayoutView];
    [labelView addSubview:thirdLabel];
    [thirdLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:secondLabel withOffset:5];
    [thirdLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [thirdLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [thirdLabel autoSetDimension:ALDimensionWidth toSize:40];
    thirdLabel.layer.cornerRadius = 20;
    thirdLabel.layer.masksToBounds = YES;
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.textColor = [UIColor whiteColor];
    
    fouthLabel = [UILabel newAutoLayoutView];
    [labelView addSubview:fouthLabel];
    [fouthLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [fouthLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:thirdLabel withOffset:5];
    [fouthLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [fouthLabel autoSetDimension:ALDimensionWidth toSize:40];
    fouthLabel.layer.cornerRadius = 20;
    fouthLabel.layer.masksToBounds = YES;
    fouthLabel.textAlignment = NSTextAlignmentCenter;
    fouthLabel.textColor = [UIColor whiteColor];
    
    sendMsgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:sendMsgBtn];
    sendMsgBtn.layer.cornerRadius = 5;
    sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:50 blue:57 alpa:1];
    sendMsgBtn.tintColor = [UIColor whiteColor];
    [sendMsgBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:telPhoneText withOffset:20];
    [sendMsgBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:msgText withOffset:15];
    [sendMsgBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [sendMsgBtn autoSetDimension:ALDimensionHeight toSize:40];
    [sendMsgBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendMsgBtn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    sendMsgBtn.tag = 100001;
    
    registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view  addSubview:registBtn];
    registBtn.layer.cornerRadius = 5;
   
    registBtn.tintColor = [UIColor whiteColor];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:msgText withOffset:100];
    [registBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [registBtn autoPinEdgeToSuperviewEdge: ALEdgeRight withInset:50];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn setTitle:@"下一步" forState:UIControlStateNormal];
    registBtn.backgroundColor = [UIColor grayColor];
    registBtn.userInteractionEnabled = NO;
    [registBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)nextStep {

    if ([info isEqualToString:msgText.text]) {
        PPPwdViewController  *pwdVC = [[PPPwdViewController alloc]init];
        pwdVC.userTelPhone = telPhoneText.text;
        pwdVC.showNavi = YES;
        [self.navigationController pushViewController:pwdVC animated:YES];
    }else {
        [MBProgressHUD showError:@"验证码错误" toView:self.view];
    }
    
    

}

- (void)textChange:(NSNotification *)notifi
{
    msgText.alpha = 0.5;
    switch ([msgText.text length]) {
        case 0: {
            firstLabel.text   = @"";
            secondLabel.text   = @"";
            thirdLabel.text = @"";
            fouthLabel.text  = @"";
            
            firstLabel.backgroundColor   = [UIColor whiteColor];
            secondLabel.backgroundColor   = [UIColor whiteColor];
            thirdLabel.backgroundColor = [UIColor whiteColor];
            fouthLabel.backgroundColor  = [UIColor whiteColor];
            
            if (timer <= 0) {
                [timer invalidate];
                timer=nil;
               // [sendMsgBtn setTitle:@"重发" forState:UIControlStateNormal];
            }
            //MMColor(255, 70, 92, 1);
            sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:70 blue:92 alpa:1];
            break;
        }
        case 1: {
            firstLabel.text   = [msgText.text substringWithRange:NSMakeRange(0, 1)];
            secondLabel.text   = @"";
            thirdLabel.text = @"";
            fouthLabel.text  = @"";
            //MMColor(251, 44, 75, 1);
            firstLabel.backgroundColor   = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:1];
            secondLabel.backgroundColor   = [UIColor whiteColor];
            thirdLabel.backgroundColor = [UIColor whiteColor];
            fouthLabel.backgroundColor  = [UIColor whiteColor];
            
            [timer invalidate];
            timer = nil;
            [sendMsgBtn setTitle:@"重发" forState:UIControlStateNormal];
            registBtn.userInteractionEnabled = YES;
           // MMColor(255, 70, 92, 1);
            sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:70 blue:92 alpa:1];
            break;
        }
        case 2: {
            firstLabel.text   = [msgText.text substringWithRange:NSMakeRange(0, 1)];
            secondLabel.text   = [msgText.text substringWithRange:NSMakeRange(1, 1)];
            thirdLabel.text = @"";
            fouthLabel.text  = @"";
            // 248 85 72 1
            firstLabel.backgroundColor   = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:1];
            secondLabel.backgroundColor   = [colorTurn colorTurnWithRed:248 greed:85 blue:72 alpa:1];
            thirdLabel.backgroundColor = [UIColor whiteColor];
            fouthLabel.backgroundColor  = [UIColor whiteColor];
            
            [timer invalidate];
            timer = nil;
           [sendMsgBtn setTitle:@"重发" forState:UIControlStateNormal];
            registBtn.userInteractionEnabled = YES;
            sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:70 blue:92 alpa:1];
            break;
        }
        case 3: {
            firstLabel.text   = [msgText.text substringWithRange:NSMakeRange(0, 1)];
            secondLabel.text   = [msgText.text substringWithRange:NSMakeRange(1, 1)];
            thirdLabel.text = [msgText.text substringWithRange:NSMakeRange(2, 1)];
            fouthLabel.text  = @"";
            //253 134 77 1
            firstLabel.backgroundColor   = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:1];
            secondLabel.backgroundColor   = [colorTurn colorTurnWithRed:248 greed:85 blue:72 alpa:1];
            thirdLabel.backgroundColor = [colorTurn colorTurnWithRed:253 greed:134 blue:77 alpa:1];
            fouthLabel.backgroundColor  = [UIColor whiteColor];
            
            [timer invalidate];
            timer = nil;
           [sendMsgBtn setTitle:@"重发" forState:UIControlStateNormal];
            registBtn.userInteractionEnabled = YES;
            sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:70 blue:92 alpa:1];
            break;
        }
        case 4: {
            firstLabel.text   = [msgText.text substringWithRange:NSMakeRange(0, 1)];
            secondLabel.text   = [msgText.text substringWithRange:NSMakeRange(1, 1)];
            thirdLabel.text = [msgText.text substringWithRange:NSMakeRange(2, 1)];
            fouthLabel.text  = [msgText.text substringWithRange:NSMakeRange(3, 1)];
            //252 173 72 1
            firstLabel.backgroundColor   = [colorTurn colorTurnWithRed:251 greed:44 blue:75 alpa:1];
            secondLabel.backgroundColor   =[colorTurn colorTurnWithRed:248 greed:85 blue:72 alpa:1];
            thirdLabel.backgroundColor = [colorTurn colorTurnWithRed:253 greed:134 blue:77 alpa:1];
            fouthLabel.backgroundColor  = [colorTurn colorTurnWithRed:252 greed:173 blue:72 alpa:1];
            
           [sendMsgBtn setTitle:@"完成" forState:UIControlStateNormal];
            sendMsgBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:70 blue:92 alpa:1];
            registBtn.userInteractionEnabled = YES;
             registBtn.backgroundColor = [colorTurn colorTurnWithRed:255 greed:50 blue:57 alpa:1];
            break;
        }
        default:
            break;
    }
    
}


/**
 *  发送验证码
 */
- (void)sendMsg {

    if ([self checkTelPhoneNum]) {
        sendMsgBtn.userInteractionEnabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateBtnTitle) userInfo:nil repeats:YES];
        [timer fire];
        [self createInfo];
        [self getMsgWithUrl:@"http://223.4.131.214:8080/mt/"];

    }else {
    
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
    
    }
   
    
    
}

- (BOOL)checkTelPhoneNum {

    if (telPhoneText.text.length<11||telPhoneText.text.length>13||[telPhoneText.text isEqualToString:@""]) {
        
        return NO;
    }
    else {
    
        return YES;
    }

}

/**
 *  生成随机数
 */
- (void)createInfo {

    int temp = (arc4random()%100) + 1000;
    
    NSString *infoInt = [NSString stringWithFormat:@"%d",temp];
    
    info = infoInt;

}

/**
 *  改变btn的title
 */
- (void)updateBtnTitle {
    
    
    [sendMsgBtn setTitle:[NSString stringWithFormat:@"%d",start] forState:UIControlStateNormal];
    if (start < 1) {
        
        [sendMsgBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        sendMsgBtn.userInteractionEnabled = YES;
    }
   start--;

}

- (void) getMsgWithUrl:(NSString *)url {
//571ED184D5BFBC204BB4998BC1FFD470
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *pid = [NSString stringWithFormat:@"2026313"];
    [dic setValue:pid forKey:@"cpid"];
    NSString *pwd = [self md5HexDigest:@"982639"];
    NSString *pwdD = [pwd uppercaseString];
    [dic setValue:pwdD forKey:@"cppwd"];
   
    [dic setValue:telPhoneText.text forKey:@"phone"];
    [dic setValue:info forKey:@"msgtext"];
    
    AFHTTPRequestOperation *op = [manger POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"resonse:%@",dic);
        NSLog(@"dic:%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];



}

/**
 *  对字符串的urlencode 、 urldecode
 *
 *  @return 返回编码后的字符串
 */
- (NSString *)stringByDecodingURLFormat:(NSString *)result
{
    result = [ result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}
#pragma -mark 对账户的密码进行加密
-(NSString *)md5HexDigest:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [telPhoneText endEditing:YES];
    [msgText endEditing:YES];

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
