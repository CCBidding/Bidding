//
//  PPRegistViewController.m
//  招标
//
//  Created by ppan on 15/7/13.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPRegistViewController.h"

@interface PPRegistViewController ()<IGLDropDownMenuDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>{

    UITableView *myTableView;
    CustomField *nameTextField;
    CustomField *pwdTextField;
    IGLDropDownMenu *companyCategory;
    UIButton     *infomationBtn;
    TYGSelectMenu *menuLevel;
    TYGSelectMenu *menuLevel2;
    CustomField   *userTextField;
    CustomField   *surePwdTextField;
    UIScrollView  *myScrollView;
    CustomField   *numComTextField;
    CustomField   *headTextField;
    CustomField    *telTextField;
    CustomField   *mailTextField;
    CustomField   *detailTextField;
    UIButton *headInfoBtn;
    UIButton *backLogin;     //返回登录按钮
    UILabel *surePwdLabel;
    
   
    PPGuideUserView *guidView;  //引导动画界面
    NSArray   *getArr;
    NSArray   *companySelectArr;
    NSArray    *headSelectArr;
}
@property (nonatomic, strong)  RCAnimatedImagesView *animatedImageView;
@end

@implementation PPRegistViewController


+ (PPRegistViewController *)shareInstance{
    
    static PPRegistViewController *registVC = nil ;
    if (!registVC) {
        registVC = [[PPRegistViewController alloc]init];
    }
    return registVC;
}
-(void)viewWillAppear:(BOOL)animated{
 [_animatedImageView startAnimating];
  self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"注册";
    getArr = [[NSArray alloc]init];
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(changeTitle:) name:@"isSelectArr" object:nil];
 
}
- (void)changeTitle:(NSNotification *)userInfo{

    NSDictionary *dic = userInfo.userInfo;
  
    NSArray *arr = dic[@"arr"];
    NSString *isCom = dic[@"isCompany"];
   
    
   
    if (arr.count > 0 && [isCom isEqualToString:@"isCompany"]) {
        
       // [self createAnimalGradeUserAction];
        companySelectArr = arr;
        [self createAnimalGradeUserActionToView:infomationBtn];
        NSString *title = [NSString stringWithFormat:@"您一共选择%lu种资质",(unsigned long)arr.count];
        [infomationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [infomationBtn setTitle:title forState:UIControlStateNormal];

    }else if (arr.count>0 && [isCom isEqualToString:@"noCompany"]){
    
         [self createAnimalGradeUserActionToView:headInfoBtn];
        NSString *title = [NSString stringWithFormat:@"您一共选择%lu种资质",(unsigned long)arr.count];
        [headInfoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headInfoBtn setTitle:title forState:UIControlStateNormal];
    
        headSelectArr = arr;
    }
   
}
/**
 *  在一个视图上创建一个引导动画
 */

- (void)createAnimalGradeUserActionToView:(UIView *)view{
    
    

    CGRect rect = CGRectMake(view.frame.origin.x+20, view.frame.origin.y+20, 150.0f, 35.0f);

    guidView = [[PPGuideUserView alloc]initWithFrame:rect backImage:[UIImage imageNamed:@"change_search_tip.png"] msgStr:@"长按显示已选择数据" txtColor:[colorTurn RGBColorFromHexString:@"#ffffff" alpha:1.0f]];
    
    [myScrollView addSubview:guidView];

    CABasicAnimation *jumpAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    jumpAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    jumpAnimation.toValue = [NSNumber numberWithFloat:10.0f];
    
    jumpAnimation.duration = 0.5f;//动画持续时间
    jumpAnimation.repeatCount = 10;//动画重复次数
    jumpAnimation.autoreverses = YES;//是否自动重复
    [guidView.layer addAnimation:jumpAnimation forKey:@"animateLayer"];
    
    [self performSelector:@selector(removeViewWithView) withObject:self afterDelay:5];
    
    
}

- (void)removeViewWithView {
    
    [guidView removeFromSuperview];
    
}



- (void)createUI{

//    [self.view bk_whenTapped:^{
//        [self.view endEditing:YES];
//    }];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[colorTurn colorTurnWithRed:255 greed:255 blue:255 alpa:1], NSForegroundColorAttributeName,[UIFont fontWithName:@"STHeitiSC-Light" size:20.0], NSFontAttributeName, nil]];
    

    _animatedImageView = [RCAnimatedImagesView newAutoLayoutView];
    _animatedImageView.delegate = self;
    [self.view addSubview:_animatedImageView];
    [_animatedImageView bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
    [_animatedImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    myScrollView = [UIScrollView newAutoLayoutView];
    myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    myScrollView.showsHorizontalScrollIndicator = YES;
    myScrollView.delegate = self;
   
    [_animatedImageView addSubview:myScrollView];
    [myScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    

    
    nameTextField = [CustomField newAutoLayoutView];
    nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" * 公司名称" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    [nameTextField setNeedsLayout ];
    [nameTextField setNeedsUpdateConstraints];
    [myScrollView addSubview:nameTextField];
    numComTextField.delegate = self;
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [nameTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [nameTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320 relation:NSLayoutRelationGreaterThanOrEqual];


    userTextField = [CustomField newAutoLayoutView];
    userTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" * 用户名" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    userTextField.delegate = self;
    [myScrollView addSubview:userTextField];
    [userTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];
    [userTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [userTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
    
    
 
    pwdTextField = [CustomField newAutoLayoutView];
    pwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"* 密码" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    pwdTextField.delegate = self;
    [myScrollView addSubview:pwdTextField];
    [pwdTextField setSecureTextEntry:YES];
    [pwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userTextField withOffset:20];
    [pwdTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [pwdTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   
    

   
    surePwdTextField  = [CustomField newAutoLayoutView];
    surePwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"* 确认密码" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    [myScrollView addSubview:surePwdTextField];
    surePwdTextField.secureTextEntry = YES;
    [surePwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdTextField withOffset:20];
    [surePwdTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [surePwdTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   ;
  

    
    infomationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [infomationBtn setTitle:@"请选择公司资质" forState:UIControlStateNormal];
    [myScrollView addSubview:infomationBtn];
    infomationBtn.layer.cornerRadius = 10;
    [infomationBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [infomationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surePwdTextField withOffset:20];
    [infomationBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith *180/320];
    
    [infomationBtn setBackgroundColor:[UIColor whiteColor]];
    infomationBtn.tag = 10010;
    [infomationBtn bk_whenTapped:^{
        
        PPChooseInfoViewController *choose = [[PPChooseInfoViewController alloc]init];
        choose.showNavi = YES;
        choose.haveBack = NO;
        choose.isCompany = @"isCompany";
    
        [self.navigationController pushViewController:choose animated:YES];

        
    }];
    
    UILongPressGestureRecognizer  *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showData)];
    [infomationBtn addGestureRecognizer:press];
    

    headTextField = [CustomField newAutoLayoutView];
    headTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"* 负责人" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    headTextField.delegate = self;
    [myScrollView addSubview:headTextField];
    [headTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];
    [headTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [headTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   
    
    headInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [headInfoBtn setTitle:@"请选择负责人资质" forState:UIControlStateNormal];
    [headInfoBtn setBackgroundColor:[UIColor whiteColor]];
    headInfoBtn.layer.cornerRadius = 10;
    
    [myScrollView addSubview:headInfoBtn];
    [headInfoBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [headInfoBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headTextField withOffset:20];
    [headInfoBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith *180/320];
    headInfoBtn.tag = 10011;
    [headInfoBtn bk_whenTapped:^{

        
        PPChooseInfoViewController *choose = [[PPChooseInfoViewController alloc]init];
        choose.showNavi = YES;
        choose.haveBack = YES;
        choose.isCompany = @"noCompany";
        [self.navigationController pushViewController:choose animated:YES];
       
    }];
    
    backLogin=[UIButton newAutoLayoutView];
    [backLogin setTitle:@"返回" forState:UIControlStateNormal];
    backLogin.titleLabel.font = [UIFont fontWithName:nil size:18];
    [_animatedImageView addSubview:backLogin];
    [backLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_animatedImageView addSubview:backLogin];
    backLogin.layer.cornerRadius=5;
    [backLogin autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [backLogin autoSetDimension:ALDimensionWidth toSize:TTScreenWith*10/32];
    [backLogin autoSetDimension:ALDimensionHeight toSize:30];
    [backLogin autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [backLogin addTarget:self action:@selector(backLoginVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showDataWithHeadBtn)];
    [headInfoBtn addGestureRecognizer:pressGesture];
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.layer.cornerRadius = 10;
    [registBtn setBackgroundColor:[colorTurn colorTurnWithRed:175 greed:9 blue:35 alpa:1]];
    [myScrollView addSubview:registBtn];
    [registBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headInfoBtn withOffset:TTScreenHeight*80/568];
    [registBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith * 100/320];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn bk_whenTapped:^{
        
        [self registuser];
    }];
    
   
    
}


- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView
{
    return 3;
}

- (UIImage*)animatedImagesView:(RCAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:@"AnimatedImage"];
}
/**
 *  显示选择的资质
 */

- (void)showData{
  
        //双击显示选择数据
        PPSelectedViewController *selectVC;
    if (!selectVC) {
        selectVC = [[PPSelectedViewController alloc]init];
    }
        selectVC.showNavi = YES;
        selectVC.haveBack = YES;
        selectVC.dataArr = companySelectArr;
    [self presentViewController:selectVC animated:YES completion:nil];
    
   

}

- (void)showDataWithHeadBtn{

    //长按显示选择数据
    PPSelectedViewController *selectVC = [[PPSelectedViewController alloc]init];
    selectVC.showNavi = YES;
    selectVC.haveBack = YES;
    selectVC.dataArr = headSelectArr;
    [self.navigationController presentViewController:selectVC animated:YES completion:nil];


}

- (void)createData{

  

}

-(void)backLoginVC{
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma -mark alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (alertView.tag) {
        case 1002:
            if (buttonIndex == 0) {
                
            }else if (buttonIndex == 1){
            
            
            }
            
            break;
         case 1003:
            if (buttonIndex == 0) {
                
                [self addMessageWithMenuLevel:menuLevel2 toBtn:headInfoBtn];
            }else if(buttonIndex == 1){
            
                [self modifyMessageWithMenuLevel:menuLevel2 toBtn:headInfoBtn];
            }
            
            break;
            
            case 1004:
            if (buttonIndex == 0) {
                [self addMessageWithMenuLevel:menuLevel toBtn:infomationBtn];
                
            }else if (buttonIndex == 1){
            
            
                [self modifyMessageWithMenuLevel:menuLevel toBtn:infomationBtn];
            }
            
            break;
        default:
            break;
    }
 

}
#pragma -mark 添加
- (void)addMessageWithMenuLevel:(TYGSelectMenu *)menuleve  toBtn:(UIButton *)btn{

    //显示
    [menuleve showFromView:btn toView:myScrollView];
    
    //block回调
    [menuleve selectAtMenu:^(NSMutableArray *selectedMenuArray) {
        
        NSMutableString *title = [NSMutableString string];
        for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
            [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
        }
        if (btn.titleLabel.text && ![btn.titleLabel.text isEqualToString:@"请选择"]) {
            
            NSString *titleToTal = [NSString stringWithFormat:@"%@ , %@",btn.titleLabel.text,title];
            [btn setTitle:titleToTal forState:UIControlStateNormal];
        }
        else
            [btn setTitle:title forState:UIControlStateNormal];
    }];


}

- (void)modifyMessageWithMenuLevel :(TYGSelectMenu *)menue toBtn:(UIButton *)btn{

    //显示
    [menue showFromView:btn toView:myScrollView];
    
    
    //block回调
    [menue selectAtMenu:^(NSMutableArray *selectedMenuArray) {
        
        NSMutableString *title = [NSMutableString string];
        for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
            [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }];
    


}
#pragma -mark 注册方法
-(void)registuser{
    if (userTextField.text && pwdTextField.text && companySelectArr.count > 0  && headSelectArr.count > 0) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        //http://localhost:8080/GyBid/appReg/regedit.do?type=onlinedo&cname=weniter&username=wxiagn&password=123456&pro_id=2&gr_id=2&duty_name=wangwu&dpro_id=1&dqu_id=2
        NSDictionary *dic = @{@"cname":nameTextField.text,@"username":userTextField.text,@"password":pwdTextField.text,@"pro_id":companySelectArr[0][@"pro_id"],@"gr_id":companySelectArr[0][@"gr_id"],@"duty_name":headTextField.text,@"dpro_id":headSelectArr[0][@"pro_id"],@"dqu_id":headSelectArr[0][@"gr_id"]};
        
        AFHTTPRequestOperation *op = [manager POST:TTRegistUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
                [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTsessinid];
                [MBProgressHUD showSuccess:@"注册成功" toView:myScrollView];
                
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
        }];
        [op start];
        
  
    }else{
    
    
        [MBProgressHUD showError:@"请完善信息再注册！" toView:myScrollView];
    
    }
    
    
}

-(void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - IGLDropDownMenuDelegate

- (void)selectedItemAtIndex:(NSInteger)index
{
 
}
#pragma -mark textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

   
    [menuLevel2 disMiss];
    [menuLevel disMiss];

}

#pragma -mark scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [nameTextField endEditing:YES];
    [pwdTextField endEditing:YES];
    [userTextField endEditing:YES];
    [numComTextField endEditing:YES];
    [headTextField endEditing:YES];
    [telTextField endEditing:YES];
    [mailTextField endEditing:YES];
    [detailTextField endEditing:YES];
    [surePwdTextField endEditing:YES];
    [menuLevel disMiss];
    [menuLevel2 disMiss];
    if (pwdTextField.text && surePwdTextField.text && ![pwdTextField.text isEqualToString:surePwdTextField.text]) {
        
        [MBProgressHUD showError:@"两次输入的密码不正确" toView:myScrollView];
    }

}


- (void)viewWillDisappear:(BOOL)animated{

    [menuLevel disMiss];
    [menuLevel2 disMiss];
    [_animatedImageView stopAnimating];

}

- (void)viewDidUnload
{
    _animatedImageView=nil;
    
    [super viewDidUnload];
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
