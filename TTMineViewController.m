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
    self.navigationController.navigationBar.barTintColor=TTColor(255, 48, 48, 1);
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    // Do any additional setup after loading the view.
}

<<<<<<< HEAD
- (void)createUI{

    myTableView = [UITableView newAutoLayoutView];
    [self.view addSubview:myTableView];
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    myTableView.delegate = (id<UITableViewDelegate>)self;
    myTableView.dataSource = (id<UITableViewDataSource>)self;
    

}
- (void)createData{

    dataArr = [NSArray arrayWithObjects:@"退出登录", nil];
    

}
#pragma -mark  tableView delegate
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.textLabel.text = dataArr[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [MMUserDefaultTool removeObjectForKey:RRToken];
//    RROtherLoginViewController *login = [[RROtherLoginViewController alloc] init];
//    login.showNavi = NO;
//    login.haveBack = NO;
//    [[AppDelegate shared].window setRootViewController:login];
    
    [TTUserDefaultTool removeObjectForKey:TTusername];
    HomeViewController *home = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
    self.view.window.rootViewController = nav;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
=======
-(void)createUI{
    

>>>>>>> 8bb36860ca65d29e942ca543b88ab5f65ad4b7f0


}



@end
