//
//  PPRegistViewController.m
//  招标
//
//  Created by ppan on 15/7/13.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPRegistViewController.h"

@interface PPRegistViewController ()<UITableViewDataSource,UITableViewDelegate,IGLDropDownMenuDelegate>{

    UITableView *myTableView;
    NSArray     *dataArr;
    UITextField *nameTextField;
    UITextField *pwdTextField;
    IGLDropDownMenu *companyCategory;
    UIButton     *infomationBtn;
    TYGSelectMenu *menuLevel;
    TYGSelectMenu *menuLevel2;
    UIScrollView  *scrollView;
    UITextField   *numComTextField;
    UITextField   *headTextField;
    UITextField    *telTextField;
    UITextField   *mailTextField;
    UITextField   *detailTextField;
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
    
    [self createData];
    [self createUI];
}
- (void)createUI{


    scrollView = [UIScrollView newAutoLayoutView];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.2);
    scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    [scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UILabel *nameLable = [UILabel newAutoLayoutView];
    nameLable.text = @"公司名称";
    [nameLable setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
    [scrollView addSubview:nameLable];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    [nameLable autoSetDimension:ALDimensionWidth toSize:100];
    [nameLable autoSetDimension:ALDimensionHeight toSize:30];
    nameTextField = [UITextField newAutoLayoutView];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:nameTextField];
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    [nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:130];
    [nameTextField autoSetDimension:ALDimensionWidth toSize:200];
    [nameTextField autoSetDimension:ALDimensionHeight toSize:30];
    
    UILabel *pwdLable = [UILabel newAutoLayoutView];
    pwdLable.text = @"密码";
    [scrollView addSubview:pwdLable];
    [pwdLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:120];
    [pwdLable autoSetDimension:ALDimensionHeight toSize:30];
    [pwdLable autoSetDimension:ALDimensionWidth toSize:100];
    pwdTextField = [UITextField newAutoLayoutView];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:pwdTextField];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:120];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:130];
    [pwdTextField autoSetDimension:ALDimensionWidth toSize:200];
    [pwdTextField autoSetDimension:ALDimensionHeight toSize:30];
    
    
    UILabel *categoryLabel = [UILabel newAutoLayoutView];
    categoryLabel.text = @"公司类别";
    [scrollView addSubview:categoryLabel];
    [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:170];
    [categoryLabel autoSetDimension:ALDimensionWidth toSize:100];
    [categoryLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    companyCategory = [[IGLDropDownMenu alloc]init];
    companyCategory.menuText = @"请选择公司类别";
    NSArray *itemsData = @[@{@"image":@"sun.png",@"title":@"Sun"},
                             @{@"image":@"clouds.png",@"title":@"Clouds"},];
    
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < itemsData.count; i++) {
        NSDictionary *dict = itemsData[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    companyCategory.dropDownItems = dropdownItems;
    companyCategory.paddingLeft = 15;
    companyCategory.delegate = self;
    [companyCategory setFrame:CGRectMake(130, 170, 200, 30)];
    companyCategory.type = IGLDropDownMenuTypeStack;
    companyCategory.flipWhenToggleView = YES;
    [companyCategory reloadView];
    [scrollView addSubview:companyCategory];
    
    
    UILabel *companyInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 260, 100, 30)];
    companyInfoLabel.text = @"公司资质";
    [scrollView addSubview:companyInfoLabel];
    infomationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [infomationBtn setTitle:@"请选择" forState:UIControlStateNormal];
    
    [infomationBtn setFrame:CGRectMake(130, 260, 200, 30)];
    [infomationBtn setBackgroundColor:[UIColor whiteColor]];
    [infomationBtn bk_whenTapped:^{
        //显示
        [menuLevel showFromView:infomationBtn];
        [menuLevel2 disMiss];
        
        //block回调
        [menuLevel selectAtMenu:^(NSMutableArray *selectedMenuArray) {
            
            NSMutableString *title = [NSMutableString string];
            for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
            }
            if (infomationBtn.titleLabel.text && ![infomationBtn.titleLabel.text isEqualToString:@"请选择"]) {
                
                NSString *titleToTal = [NSString stringWithFormat:@"%@ , %@",infomationBtn.titleLabel.text,title];
                [infomationBtn setTitle:titleToTal forState:UIControlStateNormal];
            }
            else
            [infomationBtn setTitle:title forState:UIControlStateNormal];
        }];

    }];
    [scrollView addSubview:infomationBtn];
    
    UILabel *numComLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 300, 100, 30)];
    numComLabel.text = @"机构代码";
    [scrollView addSubview:numComLabel];
    numComTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 300, 200, 30)];
    numComTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:numComTextField];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 350, 100, 30)];
    headLabel.text = @"负责人";
    [scrollView addSubview:headLabel];
    headTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 350, 200, 30)];
    headTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:headTextField];
    
    UILabel *headInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 400, 200, 30)];
    headInfoLabel.text = @"负责人资质";
    [scrollView addSubview:headInfoLabel];
    
    UIButton *headInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [headInfoBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [headInfoBtn setFrame:CGRectMake(130, 400, 200, 30)];
    [scrollView addSubview:headInfoBtn];
    [headInfoBtn bk_whenTapped:^{
        [menuLevel2 showFromView:headInfoBtn];
        [menuLevel disMiss];
        
        //block回调
        [menuLevel2 selectAtMenu:^(NSMutableArray *selectedMenuArray) {
            
            NSMutableString *title = [NSMutableString string];
            for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
            }
            
            [headInfoBtn setTitle:title forState:UIControlStateNormal];
        }];

    }];
    
    UILabel *telLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 450, 100, 30)];
    telLable.text = @"联系电话";
    [scrollView addSubview:telLable];
    telTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 450, 200, 30)];
    telTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:telTextField];
    
    UILabel *mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 490, 100, 30)];
    mailLabel.text = @"邮箱";
    [scrollView addSubview:mailLabel];
    
    mailTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 490, 200, 30)];
    mailTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:mailTextField];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 540, 100, 30)];
    detailLabel.text = @"主要业绩";
    [scrollView addSubview:detailLabel];
    
    detailTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 540, 200, 100)];
    detailTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview: detailTextField];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registBtn setFrame:CGRectMake(140, 660, 100, 30)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setBackgroundColor:[UIColor redColor]];
    [scrollView addSubview:registBtn];
    
    
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
    for (int i = 0; i < 10; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel2 addChildSelectMenu:menu1 forParent:nil];
        
        for (int j = 0; j < 15; j++) {
            TYGSelectMenuEntity *menu2 = [[TYGSelectMenuEntity alloc] init];
            menu2.title = [NSString stringWithFormat:@"%@-%d",menu2.title,j];
            [menuLevel2 addChildSelectMenu:menu2 forParent:menu1];
            
        }
    }

}

#pragma mark - IGLDropDownMenuDelegate

- (void)selectedItemAtIndex:(NSInteger)index
{
 
}

#pragma -mark  tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"regisCell";
    PPRegistTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[PPRegistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setTag:indexPath.row];
    }
    
    cell.textLabel.text = dataArr[indexPath.row];
    return  cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
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
