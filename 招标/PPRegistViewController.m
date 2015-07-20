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
    NSArray     *dataArr;
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
}

@end

@implementation PPRegistViewController

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"注册";
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(changeTitle:) name:@"isSelectArr" object:nil];
 
}
- (void)changeTitle:(NSNotification *)userInfo{

    NSDictionary *dic = userInfo.userInfo;
  
    NSArray *arr = dic[@"arr"];
    
    if (arr.count > 0) {
        NSString *title = [NSString stringWithFormat:@"您一共选择%lu种资质",(unsigned long)arr.count];
        
        [infomationBtn setTitle:title forState:UIControlStateNormal];

    }
   
}
- (void)createUI{

//    [self.view bk_whenTapped:^{
//        [self.view endEditing:YES];
//    }];
    myScrollView = [UIScrollView newAutoLayoutView];
    myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    myScrollView.showsHorizontalScrollIndicator = YES;
    myScrollView.delegate = self;
   
    [self.view addSubview:myScrollView];
    [myScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIView *labelBackgroundView = [UIView newAutoLayoutView];
    labelBackgroundView.autoresizingMask = YES;
    labelBackgroundView.backgroundColor = [UIColor grayColor];
    labelBackgroundView.alpha = 0.3;
    [self.view addSubview:labelBackgroundView];
    [labelBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [labelBackgroundView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [labelBackgroundView autoSetDimension:ALDimensionWidth toSize:TTScreenWith*114/320];
    [labelBackgroundView autoSetDimension:ALDimensionHeight toSize:340];
    labelBackgroundView.backgroundColor = [UIColor grayColor];
    
    UILabel *nameLable = [UILabel newAutoLayoutView];
    nameLable.text = @" * 公司名称";
    nameLable.backgroundColor = [UIColor grayColor];
    [myScrollView addSubview:nameLable];
    [nameLable autoSetDimension:ALDimensionHeight toSize:30];
    [nameLable autoSetDimension:ALDimensionWidth toSize:90];
    nameLable.layer.cornerRadius = 5;
    nameLable.layer.masksToBounds = YES;
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenHeight*4/320];
    
    
    nameTextField = [CustomField newAutoLayoutView];
    [myScrollView addSubview:nameTextField];
    numComTextField.delegate = self;
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TTScreenHeight*4/320];
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [nameTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320 relation:NSLayoutRelationGreaterThanOrEqual];

    UILabel *userLabel = [UILabel newAutoLayoutView];
    [myScrollView addSubview:userLabel];
    userLabel.layer.cornerRadius =5;
    userLabel.layer.masksToBounds = YES;
    userLabel.backgroundColor = [UIColor grayColor];
    userLabel.text = @" * 用户名";
    [userLabel autoSetDimension:ALDimensionHeight toSize:30];
    [userLabel autoSetDimension:ALDimensionWidth toSize:90];
    [userLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [userLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];

    userTextField = [CustomField newAutoLayoutView];
    userTextField.delegate = self;
    [myScrollView addSubview:userTextField];
    [userTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];
    [userTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [userTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
    
    
    UILabel *pwdLable = [UILabel newAutoLayoutView];
    pwdLable.text = @" * 密码";
    pwdLable.backgroundColor = [UIColor grayColor];
    pwdLable.layer.cornerRadius = 5;
    pwdLable.layer.masksToBounds = YES;
    [myScrollView addSubview:pwdLable];
    [pwdLable autoSetDimension:ALDimensionWidth toSize:90];
    [pwdLable autoSetDimension:ALDimensionHeight toSize:30];
    [pwdLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [pwdLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
 
    pwdTextField = [CustomField newAutoLayoutView];
    pwdTextField.delegate = self;
    [myScrollView addSubview:pwdTextField];
    [pwdTextField setSecureTextEntry:YES];
    [pwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*115/320];
    [pwdTextField autoSetDimension:ALDimensionWidth toSize:TTScreenWith*180/320];
   
    
    surePwdLabel = [UILabel newAutoLayoutView];
    surePwdLabel.text = @" * 确认密码";
    surePwdLabel.backgroundColor = [UIColor grayColor];
    surePwdLabel.layer.cornerRadius = 5;
    surePwdLabel.layer.masksToBounds = YES;
    [myScrollView addSubview:surePwdLabel];
    [surePwdLabel autoSetDimension:ALDimensionHeight toSize:30];
    [surePwdLabel autoSetDimension:ALDimensionWidth toSize:90];
    [surePwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [surePwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdLable withOffset:20];
   
    surePwdTextField  = [CustomField newAutoLayoutView];
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
    companyInfoLabel.backgroundColor = [UIColor grayColor];
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
    [infomationBtn bk_whenTapped:^{
//        if (infomationBtn.titleLabel.text && ![infomationBtn.titleLabel.text isEqualToString:@"请选择"]) {
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的选择是？" delegate:self cancelButtonTitle:@"继续添加" otherButtonTitles:@"修改", nil];
//            alert.tag = 1004;
//            [alert show];
//            
//        }
//        else{
//            
//            //显示
//            [menuLevel showFromView:infomationBtn toView:myScrollView];
//            
//            [menuLevel2 disMiss];
//            //block回调
//            [menuLevel selectAtMenu:^(NSMutableArray *selectedMenuArray) {
//                
//                NSMutableString *title = [NSMutableString string];
//                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
//                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
//                }
//                
//                [infomationBtn setTitle:title forState:UIControlStateNormal];
//            }];
//            
//        }
        
        PPChooseInfoViewController *choose = [[PPChooseInfoViewController alloc]init];
        choose.showNavi = YES;
        choose.haveBack = YES;
        
        [self.navigationController pushViewController:choose animated:YES];
        
    }];
    
    
    
    
//    UILabel *numComLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 300, 100, 30)];
//    //UILabel *numComLabel = [UILabel newAutoLayoutView];
//    numComLabel.text = @"机构代码";
//    [scrollView addSubview:numComLabel];
//
//    numComTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 300, 200, 30)];
//    numComTextField.borderStyle = UITextBorderStyleRoundedRect;
//    numComTextField.delegate = self;
//    [scrollView addSubview:numComTextField];
    
    UILabel *headLabel = [UILabel newAutoLayoutView];
    headLabel.text = @" * 负责人";
    headLabel.backgroundColor = [UIColor grayColor];
    [myScrollView addSubview:headLabel];
    headLabel.layer.cornerRadius = 5;
    headLabel.layer.masksToBounds = YES;
    [headLabel autoSetDimension:ALDimensionHeight toSize:30];
    [headLabel autoSetDimension:ALDimensionWidth toSize:90];
    [headLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:TTScreenWith*15/320];
    [headLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];

    headTextField = [CustomField newAutoLayoutView];
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
    headInfoLabel.backgroundColor = [UIColor grayColor];
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
  
    [headInfoBtn bk_whenTapped:^{
        if (headInfoBtn.titleLabel.text && ![headInfoBtn.titleLabel.text isEqualToString:@"请选择"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的选择是？" delegate:self cancelButtonTitle:@"继续添加" otherButtonTitles:@"修改", nil];
            alert.tag = 1003;
            [alert show];
           
        }
        else{
        
            //显示
            [menuLevel2 showFromView:headInfoBtn toView:myScrollView];
            
            [menuLevel disMiss];
            //block回调
            [menuLevel2 selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
                }
                
                [headInfoBtn setTitle:title forState:UIControlStateNormal];
            }];
        
        }
       
    }];
    
//    UILabel *telLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 450, 100, 30)];
//    telLable.text = @"联系电话";
//    [scrollView addSubview:telLable];
//    telTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 450, 200, 30)];
//    telTextField.borderStyle = UITextBorderStyleRoundedRect;
//    telTextField.delegate = self;
//    [scrollView addSubview:telTextField];
//    
//    UILabel *mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 490, 100, 30)];
//    mailLabel.text = @"邮箱";
//    [scrollView addSubview:mailLabel];
//    
//    mailTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 490, 200, 30)];
//    mailTextField.borderStyle = UITextBorderStyleRoundedRect;
//    mailTextField.delegate = self;
//    [scrollView addSubview:mailTextField];
//    
//    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 540, 100, 30)];
//    detailLabel.text = @"主要业绩";
//    [scrollView addSubview:detailLabel];
//    
//    detailTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 540, 200, 100)];
//    detailTextField.borderStyle = UITextBorderStyleRoundedRect;
//    detailTextField .delegate = self;
//    [scrollView addSubview: detailTextField];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.layer.cornerRadius = 10;
    [registBtn setBackgroundColor:[colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1]];
    [myScrollView addSubview:registBtn];
    [registBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headInfoBtn withOffset:TTScreenHeight*80/568];
    [registBtn autoSetDimension:ALDimensionWidth toSize:TTScreenWith * 100/320];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn bk_whenTapped:^{
        
        [self registuser];
    }];
    
    
}
- (void)createData{

    dataArr = @[@"公司名称",@"用户名",@"密码",@"公司类别",@"公司资制",@"机构代码",@"负责人",@"负责人资制",@"联系电话",@"主要业绩"];
    menuLevel = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < 10; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel addChildSelectMenu:menu1 forParent:nil];
        
        for (int j = 0; j < 15; j++) {
            TYGSelectMenuEntity *menu2 = [[TYGSelectMenuEntity alloc] init];
            menu2.title = [NSString stringWithFormat:@"%@-%d",menu1.title,j];
            [menuLevel addChildSelectMenu:menu2 forParent:menu1];
            
        }
    }
    
    menuLevel2 = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < 5; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel2 addChildSelectMenu:menu1 forParent:nil];
        
        for (int j = 0; j < 10; j++) {
            TYGSelectMenuEntity *menu2 = [[TYGSelectMenuEntity alloc] init];
            menu2.title = [NSString stringWithFormat:@"%@-%d",menu1.title,j];
            [menuLevel2 addChildSelectMenu:menu2 forParent:menu1];
            
        }
    }

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
    if (userTextField.text && pwdTextField.text && surePwdTextField.text) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        AFHTTPRequestOperation *op = [manager POST:TTRegistUrl parameters:@{@"username":userTextField.text,@"password":pwdTextField.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    
        [MBProgressHUD showError:@"请输入用户名！" toView:myScrollView];
    
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
