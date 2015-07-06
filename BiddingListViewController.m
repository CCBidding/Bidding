//
//  BiddingListViewController.m
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "BiddingListViewController.h"

@interface BiddingListViewController ()<CDRTranslucentSideBarDelegate>
{
    CDRTranslucentSideBar *_sideBar;
}

@end

@implementation BiddingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self RegistSideBar];
    // Do any additional setup after loading the view from its nib.
}

-(void)creatUI{
      self.title=@"列表1";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showsideBar)];

}
-(void)showsideBar{
    [_sideBar show];

}
-(void)RegistSideBar{
    // Create SideBar and Set Properties
    _sideBar = [[CDRTranslucentSideBar alloc] init];
    _sideBar.sideBarWidth = 200;
    _sideBar.delegate = self;
    _sideBar.tag = 0;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UITableView *tableView = [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    v.backgroundColor = [UIColor clearColor];
    [tableView setTableHeaderView:v];
    [tableView setTableFooterView:v];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // Set ContentView in SideBar
    [_sideBar setContentViewInSideBar:tableView];
    
    




}

#pragma mark - Gesture Handler
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
     _sideBar.isCurrentPanGestureTarget = YES;
    [_sideBar handlePanGestureToShow:recognizer inView:self.view];
}

#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated
{
   
        NSLog(@"Left SideBar did appear");
   
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated
{
   

        NSLog(@"Left SideBar will appear");
    
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated
{
   
        NSLog(@"Left SideBar did disappear");

}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated
{
    
        NSLog(@"Left SideBar will disappear");

}

// This is just a sample for tableview menu
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        // StatuBar Height
        return 20;
    } else if (section == 1) {
        return 44;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *clearView = [[UIView alloc] initWithFrame:CGRectZero];
        clearView.backgroundColor = [UIColor clearColor];
        return clearView;
    } else if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
        headerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.bounds.size.width - 15, 44)];
        //添加分割线
        UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 44, tableView.bounds.size.width, 0.5f)];
        separatorLineView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:separatorLineView];
        label.text = @"菜单";
        [headerView addSubview:label];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0;
    } else if (indexPath.section == 1) {
        return 44;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.section == 0) {
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Menu 1";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Menu 2";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Menu 3";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}





@end
