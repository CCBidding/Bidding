//
//  TTMineViewController.m
//  招标
//
//  Created by mac chen on 15/7/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTMineViewController.h"
#import "PPHomeViewController.h"

@interface TTMineViewController ()<UITableViewDataSource,UITableViewDelegate,FDAlertViewDelegate>
{
    
    UITableView *myTableView;
    NSArray     *dataArr;
}
@end

@implementation TTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于我";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    dataArr = @[@"查看信息",@"公司资质修改",@"人员资质修改",@"关于我们",@"退出登录"];
    // Do any additional setup after loading the view.
}


- (void)createUI{
    
    myTableView = [UITableView newAutoLayoutView];
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    myTableView.delegate = (id<UITableViewDelegate>)self;
    myTableView.dataSource = (id<UITableViewDataSource>)self;
    
    
}
- (void)createData{
    
    
    
    
}
#pragma -mark  tableView delegate
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:{
            
            
            perFectMessageViewController *chose = [[perFectMessageViewController alloc]init];
            chose.showNavi = YES;
           // chose.isCompany =@"company";
            [self.navigationController pushViewController:chose animated:YES];
            
        }
            
            break;
        case 1:
        {
            
            PPChooseInfoViewController *chose = [[PPChooseInfoViewController alloc]init];
            chose.showNavi = YES;
            chose.isCompany =@"company";
            [self.navigationController pushViewController:chose animated:YES];
        }
            break;
        case 2:{
            
           
            PPChooseInfoViewController *chose = [[PPChooseInfoViewController alloc]init];
            chose.showNavi = YES;
            chose.isCompany =@"head";
            [self.navigationController pushViewController:chose animated:YES];
            
        }
            
            break;
        case 3:{
            PPAboutUsViewController *about = [[PPAboutUsViewController alloc]init];
            about.haveBack = YES;
            about.showNavi = YES;
            [self.navigationController pushViewController:about animated:YES];
        
        }
            break;
        case 4:
        {
            FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"退出登录" icon:[UIImage imageNamed:@"exclamation-icon"] message:@"你确定退出登录吗？" delegate:self buttonTitles:@"确定", @"取消", nil];
            [alert show];
            
            
        }
            break;
        default:
            break;
    }
    
    
    
}


- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    
    
    
    cell.textLabel.text = dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TTScreenWith*60/320;
    
}

/**
 *  FDAlertView delegate
 */

- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == 0) {
        [TTUserDefaultTool removeObjectForKey:TTusername];
        PPHomeViewController *home = [[PPHomeViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        self.view.window.rootViewController = nav;
    }else{
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
