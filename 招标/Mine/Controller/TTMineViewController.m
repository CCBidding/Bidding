//
//  TTMineViewController.m
//  招标
//
//  Created by mac chen on 15/7/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTMineViewController.h"


@interface TTMineViewController ()<UITableViewDataSource,UITableViewDelegate>
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
    dataArr = @[@"密码修改",@"资料修改",@"关于我们",@"退出登录"];
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

//    [MMUserDefaultTool removeObjectForKey:RRToken];
//    RROtherLoginViewController *login = [[RROtherLoginViewController alloc] init];
//    login.showNavi = NO;
//    login.haveBack = NO;
//    [[AppDelegate shared].window setRootViewController:login];
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:{
        
            PPAboutUsViewController *about = [[PPAboutUsViewController alloc]init];
            about.haveBack = YES;
            about.showNavi = YES;
            [self.navigationController pushViewController:about animated:YES];
        
        
        }
            
            break;
        case 3:
        {
            [TTUserDefaultTool removeObjectForKey:TTusername];
            HomeViewController *home = [[HomeViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
            self.view.window.rootViewController = nav;
            
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
