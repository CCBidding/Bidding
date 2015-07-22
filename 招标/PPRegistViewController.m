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
    UILabel *surePwdLabel;
    
   
    PPGuideUserView *guidView;  //引导动画界面
    NSArray   *getArr;
    NSArray   *companySelectArr;
    NSArray    *headSelectArr;
}

@end

@implementation PPRegistViewController

-(void)viewWillAppear:(BOOL)animated{

  //  self.navigationController.navigationBarHidden = NO;
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
    

    myScrollView = [UIScrollView newAutoLayoutView];
    myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    myScrollView.showsHorizontalScrollIndicator = YES;
    myScrollView.delegate = self;
   
    [self.view addSubview:myScrollView];
    [myScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIView *labelBackgroundView = [UIView newAutoLayoutView];
    labelBackgroundView.autoresizingMask = YES;
    labelBackgroundView.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    labelBackgroundView.alpha = 0.78;
    labelBackgroundView.layer.cornerRadius = 5;
    [myScrollView addSubview:labelBackgroundView];
    [labelBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [labelBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [labelBackgroundView autoSetDimension:ALDimensionWidth toSize:TTScreenWith*114/320];
    [labelBackgroundView autoSetDimension:ALDimensionHeight toSize:TTScreenHeight * 360/568];
    UILabel *nameLable = [UILabel newAutoLayoutView];
    nameLable.text = @" * 公司名称";
    nameLable.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    [myScrollView addSubview:nameLable];
    [nameLable autoSetDimension:ALDimensionHeight toSize:30];
    [nameLable autoSetDimension:ALDimensionWidth toSize:90];
    nameLable.layer.cornerRadius = 5;
    nameLable.layer.masksToBounds = YES;
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenHeight*15/320];
    
    
    nameTextField = [CustomField newAutoLayoutView];
    [nameTextField setNeedsLayout ];
    [nameTextField setNeedsUpdateConstraints];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:nameTextField];
    numComTextField.delegate = self;
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenHeight*15/320];
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [nameTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320 relation:NSLayoutRelationGreaterThanOrEqual];

    UILabel *userLabel = [UILabel newAutoLayoutView];
    [myScrollView addSubview:userLabel];
    userLabel.layer.cornerRadius =5;
    userLabel.layer.masksToBounds = YES;
    userLabel.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    userLabel.text = @" * 用户名";
    [userLabel autoSetDimension:ALDimensionHeight toSize:30];
    [userLabel autoSetDimension:ALDimensionWidth toSize:90];
    [userLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [userLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];

    userTextField = [CustomField newAutoLayoutView];
    userTextField.delegate = self;
    userTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:userTextField];
    [userTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];
    [userTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [userTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
    
    
    UILabel *pwdLable = [UILabel newAutoLayoutView];
    pwdLable.text = @" * 密码";
    pwdLable.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    pwdLable.layer.cornerRadius = 5;
    pwdLable.layer.masksToBounds = YES;
    [myScrollView addSubview:pwdLable];
    [pwdLable autoSetDimension:ALDimensionWidth toSize:90];
    [pwdLable autoSetDimension:ALDimensionHeight toSize:30];
    [pwdLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [pwdLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
 
    pwdTextField = [CustomField newAutoLayoutView];
    pwdTextField.delegate = self;
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:pwdTextField];
    [pwdTextField setSecureTextEntry:YES];
    [pwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [pwdTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   
    
    surePwdLabel = [UILabel newAutoLayoutView];
    surePwdLabel.text = @" * 确认密码";
    surePwdLabel.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    surePwdLabel.layer.cornerRadius = 5;
    surePwdLabel.layer.masksToBounds = YES;
    [myScrollView addSubview:surePwdLabel];
    [surePwdLabel autoSetDimension:ALDimensionHeight toSize:30];
    [surePwdLabel autoSetDimension:ALDimensionWidth toSize:90];
    [surePwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [surePwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdLable withOffset:20];
   
    surePwdTextField  = [CustomField newAutoLayoutView];
    surePwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:surePwdTextField];
    surePwdTextField.secureTextEntry = YES;
    [surePwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdLable withOffset:20];
    [surePwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [surePwdTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   ;
    
//    UILabel *categoryLabel = [UILabel newAutoLayoutView];
//    categoryLabel.text = @"公司类别";
//    [scrollView addSubview:categoryLabel];
//    [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
//    [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:170];
//    [categoryLabel autoSetDimension:ALDimensionWidth toSize:100];
//    [categoryLabel autoSetDimension:ALDimensionHeight toSize:30];
//    
//    companyCategory = [[IGLDropDownMenu alloc]init];
//    companyCategory.menuText = @"请选择公司类别";
//    NSArray *itemsData = @[@{@"image":@"sun.png",@"title":@"Sun"},
//                             @{@"image":@"clouds.png",@"title":@"Clouds"},];
//    
//    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
//    for (int i = 0; i < itemsData.count; i++) {
//        NSDictionary *dict = itemsData[i];
//        
//        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
//        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
//        [item setText:dict[@"title"]];
//        [dropdownItems addObject:item];
//    }
//    
//    companyCategory.dropDownItems = dropdownItems;
//    companyCategory.paddingLeft = 15;
//    companyCategory.delegate = self;
//    [companyCategory setFrame:CGRectMake(110, 170, 200, 30)];
//    companyCategory.type = IGLDropDownMenuTypeStack;
//    companyCategory.flipWhenToggleView = YES;
//    [companyCategory reloadView];
//    [scrollView addSubview:companyCategory];
//    
    
    UILabel *companyInfoLabel = [UILabel newAutoLayoutView];
    companyInfoLabel.text = @" * 公司资质";
    companyInfoLabel.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    companyInfoLabel.layer.cornerRadius = 5;
    companyInfoLabel.layer.masksToBounds = YES;
    [myScrollView addSubview:companyInfoLabel];
    [companyInfoLabel autoSetDimension:ALDimensionWidth toSize:90];
    [companyInfoLabel autoSetDimension:ALDimensionHeight toSize:30];
    [companyInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [companyInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surePwdLabel withOffset:20];

    
    infomationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [infomationBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [myScrollView addSubview:infomationBtn];
    [infomationBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [infomationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surePwdLabel withOffset:20];
    [infomationBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith *180/320];
    
    [infomationBtn setBackgroundColor:[UIColor whiteColor]];
    infomationBtn.tag = 10010;
    [infomationBtn bk_whenTapped:^{
        
        PPChooseInfoViewController *choose = [[PPChooseInfoViewController alloc]init];
        choose.showNavi = YES;
        choose.haveBack = YES;
        choose.isCompany = @"isCompany";
    
        [self.navigationController pushViewController:choose animated:YES];

        
    }];
    
    UILongPressGestureRecognizer  *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showData)];
    [infomationBtn addGestureRecognizer:press];
    
    
    UILabel *headLabel = [UILabel newAutoLayoutView];
    headLabel.text = @" * 负责人";
    headLabel.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    [myScrollView addSubview:headLabel];
    headLabel.layer.cornerRadius = 5;
    headLabel.layer.masksToBounds = YES;
    [headLabel autoSetDimension:ALDimensionHeight toSize:30];
    [headLabel autoSetDimension:ALDimensionWidth toSize:90];
    [headLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [headLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];

    headTextField = [CustomField newAutoLayoutView];
    headTextField.borderStyle = UITextBorderStyleRoundedRect;
    headTextField.delegate = self;
    [myScrollView addSubview:headTextField];
    [headTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];
    [headTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith *115/320];
    [headTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
    
    UILabel *headInfoLabel = [UILabel newAutoLayoutView];
    headInfoLabel.text = @"*负责人资质";
    headInfoLabel.font = [UIFont fontWithName:nil size:15];
    [headInfoLabel autoSetDimension:ALDimensionWidth toSize:90];
    [headInfoLabel autoSetDimension:ALDimensionHeight toSize:30];
    headInfoLabel.backgroundColor = [colorTurn colorTurnWithRed:199 greed:200 blue:202 alpa:1];
    headInfoLabel.layer.cornerRadius = 5;
    headInfoLabel.layer.masksToBounds = YES;
    [myScrollView addSubview:headInfoLabel];
    [headInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [headInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headLabel withOffset:20];
   
    
    headInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [headInfoBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [myScrollView addSubview:headInfoBtn];
    [headInfoBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith *115/320];
    [headInfoBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headLabel withOffset:20];
    [headInfoBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith *180/320];
    headInfoBtn.tag = 10011;
    [headInfoBtn bk_whenTapped:^{

        
        PPChooseInfoViewController *choose = [[PPChooseInfoViewController alloc]init];
        choose.showNavi = YES;
        choose.haveBack = YES;
        choose.isCompany = @"noCompany";
        [self.navigationController pushViewController:choose animated:YES];
       
    }];
    
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
