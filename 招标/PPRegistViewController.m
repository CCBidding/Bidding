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
    UITextField *nameTextField;
    UITextField *pwdTextField;
    IGLDropDownMenu *companyCategory;
    UIButton     *infomationBtn;
    TYGSelectMenu *menuLevel;
    TYGSelectMenu *menuLevel2;
    UITextField   *userTextField;
    UITextField   *surePwdTextField;
    UIScrollView  *myScrollView;
    UITextField   *numComTextField;
    UITextField   *headTextField;
    UITextField    *telTextField;
    UITextField   *mailTextField;
    UITextField   *detailTextField;
    UIButton *headInfoBtn;
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
 
}
- (void)createUI{


    myScrollView = [UIScrollView newAutoLayoutView];
    myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    myScrollView.showsHorizontalScrollIndicator = YES;
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    [myScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UILabel *nameLable = [UILabel newAutoLayoutView];
    nameLable.text = @"公司名称 :";
    [nameLable setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
    [myScrollView addSubview:nameLable];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:54];
    [nameLable autoSetDimension:ALDimensionWidth toSize:100];
    [nameLable autoSetDimension:ALDimensionHeight toSize:30];
    nameTextField = [UITextField newAutoLayoutView];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:nameTextField];
    numComTextField.delegate = self;
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:54];
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [nameTextField autoSetDimension:ALDimensionWidth toSize:200 relation:NSLayoutRelationGreaterThanOrEqual];

    UILabel *userLabel = [UILabel newAutoLayoutView];
    [myScrollView addSubview:userLabel];
    userLabel.text = @"用户名 :";
    [userLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [userLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLable withOffset:20];
    [nameLable autoSetDimension:ALDimensionWidth toSize:100];
    [nameLable autoSetDimension:ALDimensionHeight toSize:30];
    userTextField = [UITextField newAutoLayoutView];
    userTextField.delegate = self;
    [myScrollView addSubview:userTextField];
    userTextField.borderStyle = UITextBorderStyleRoundedRect;
    [userTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameTextField withOffset:20];
    [userTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [userTextField autoSetDimension:ALDimensionWidth toSize:200];
    
    
    UILabel *pwdLable = [UILabel newAutoLayoutView];
    pwdLable.text = @"密码";
    [myScrollView addSubview:pwdLable];
    [pwdLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [pwdLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
    [pwdLable autoSetDimension:ALDimensionHeight toSize:30];
    [pwdLable autoSetDimension:ALDimensionWidth toSize:100];
    pwdTextField = [UITextField newAutoLayoutView];
    pwdTextField.delegate = self;
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myScrollView addSubview:pwdTextField];
    [pwdTextField setSecureTextEntry:YES];
    [pwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:userLabel withOffset:20];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [pwdTextField autoSetDimension:ALDimensionWidth toSize:200];
    [pwdTextField autoSetDimension:ALDimensionHeight toSize:30];
    
    UILabel *surePwdLabel = [UILabel newAutoLayoutView];
    surePwdLabel.text = @"确认密码";
    [myScrollView addSubview:surePwdLabel];
    [surePwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [surePwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdLable withOffset:20];
    [surePwdLabel autoSetDimension:ALDimensionWidth toSize:100];
    [surePwdLabel autoSetDimension:ALDimensionHeight toSize:30];
    surePwdTextField  = [UITextField newAutoLayoutView];
    [myScrollView addSubview:surePwdTextField];
    surePwdTextField.secureTextEntry = YES;
    [surePwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdLable withOffset:20];
    [surePwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    surePwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [surePwdTextField autoSetDimension:ALDimensionWidth toSize:200];
    [surePwdTextField autoSetDimension:ALDimensionHeight toSize:30];
    
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
    companyInfoLabel.text = @"公司资质";
    [myScrollView addSubview:companyInfoLabel];
    [companyInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [companyInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surePwdLabel withOffset:20];
    [companyInfoLabel autoSetDimension:ALDimensionHeight toSize:30];
    [companyInfoLabel autoSetDimension:ALDimensionWidth toSize:100];
    infomationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [infomationBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [myScrollView addSubview:infomationBtn];
    [infomationBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [infomationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:surePwdLabel withOffset:20];
    [infomationBtn autoSetDimension:ALDimensionWidth toSize:200];
    [infomationBtn autoSetDimension:ALDimensionHeight toSize:30];
    [infomationBtn setBackgroundColor:[UIColor whiteColor]];
    [infomationBtn bk_whenTapped:^{
        if (infomationBtn.titleLabel.text && ![infomationBtn.titleLabel.text isEqualToString:@"请选择"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的选择是？" delegate:self cancelButtonTitle:@"继续添加" otherButtonTitles:@"修改", nil];
            alert.tag = 1004;
            [alert show];
            
        }
        else{
            
            //显示
            [menuLevel showFromView:infomationBtn toView:myScrollView];
            
            [menuLevel2 disMiss];
            //block回调
            [menuLevel selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
                }
                
                [infomationBtn setTitle:title forState:UIControlStateNormal];
            }];
            
        }
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
    headLabel.text = @"负责人";
    [myScrollView addSubview:headLabel];
    [headLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [headLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];
    [headLabel autoSetDimension:ALDimensionWidth toSize:100];
    [headLabel autoSetDimension:ALDimensionHeight toSize:30];
    headTextField = [UITextField newAutoLayoutView];
    headTextField.borderStyle = UITextBorderStyleRoundedRect;
    headTextField.delegate = self;
    [myScrollView addSubview:headTextField];
    [headTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infomationBtn withOffset:20];
    [headTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [headTextField autoSetDimension:ALDimensionHeight toSize:30];
    [headTextField autoSetDimension:ALDimensionWidth toSize:200];
    
    UILabel *headInfoLabel = [UILabel newAutoLayoutView];
    headInfoLabel.text = @"负责人资质";
    [myScrollView addSubview:headInfoLabel];
    [headInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [headInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headLabel withOffset:20];
    [headInfoLabel autoSetDimension:ALDimensionWidth toSize:100];
    [headInfoLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    headInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [headInfoBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [myScrollView addSubview:headInfoBtn];
    [headInfoBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [headInfoBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headLabel withOffset:20];
    [headInfoBtn autoSetDimension:ALDimensionHeight toSize:30];
    [headInfoBtn autoSetDimension:ALDimensionWidth toSize:200];
  
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
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headInfoBtn withOffset:80];
    [registBtn autoSetDimension:ALDimensionWidth toSize:100];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn bk_whenTapped:^{
        [self dismissViewControllerAnimated:YES completion:nil];
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
    [numComTextField endEditing:YES];
    [headTextField endEditing:YES];
    [telTextField endEditing:YES];
    [mailTextField endEditing:YES];
    [detailTextField endEditing:YES];
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
