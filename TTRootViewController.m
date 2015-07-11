//
//  TTRootViewController.m
//  招标
//
//  Created by mac chen on 15/7/11.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTRootViewController.h"
#import "TTMineViewController.h"
#import "BiddingListViewController.h"
#import "BiddingListWinViewController.h"

@interface TTRootViewController ()
{
    UIImageView *tabBarView;//自定义的覆盖原先的tarbar的控件
    
    MyButton  *previousBtn;//记录前一次选中的按钮
}

@end

@implementation TTRootViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
        //        if ([obj isKindOfClass:[]]) {
        //
        //        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tabBar.hidden = YES;
    // CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    
    //_tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    //wsq
    tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    tabBarView.userInteractionEnabled = YES;
    tabBarView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:_tabBarView];
    //wsq
    [self.tabBar addSubview:tabBarView];
    
    
    BiddingListViewController *friendVC=[[BiddingListViewController alloc]init];
    friendVC.haveBack=NO;
    friendVC.showNavi=YES;
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:friendVC];
    BiddingListWinViewController *postVC=[[BiddingListWinViewController alloc]init];
    postVC.haveBack=NO;
    postVC.showNavi=YES;
    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:postVC];
    TTMineViewController *settingVC=[[TTMineViewController alloc]init];
    settingVC.haveBack=NO;
    settingVC.showNavi=YES;
    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:settingVC];
    
    
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3, nil];
    
    [self creatButtonWithNormalName:@"callbid_tb_img_no" andSelectName:@"callbid_tb_img_yes" andTitle:@"招标" andIndex:0];
    [self creatButtonWithNormalName:@"bidded_tb_img_no" andSelectName:@"bidded_tb_img_yes" andTitle:@"找中标" andIndex:1];
    //[self creatButtonWithNormalName:@"tabbar_info" andSelectName:@"tabbar_info_selected" andTitle:@"信息" andIndex:2];
    [self creatButtonWithNormalName:@"aboutme_tb_img_no" andSelectName:@"aboutme_tb_img_yes" andTitle:@"关于我" andIndex:2];
    MyButton * button = tabBarView.subviews[0];
    [self changeViewController:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    MyButton * customButton = [MyButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = tabBarView.frame.size.width / 3;
    CGFloat buttonH = tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(TTScreenWith/3 * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    //[customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    //这里应该设置选中状态的图片。wsq
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        previousBtn = customButton;
        previousBtn.selected = YES;
    }
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(MyButton *)sender
{
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        previousBtn.selected = ! previousBtn.selected;
        previousBtn = sender;
        previousBtn.selected = YES;
    }
}


@end
