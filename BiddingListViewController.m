//
//  BiddingListViewController.m
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "BiddingListViewController.h"
#import "BiddinglistTableViewCell.h"

@interface BiddingListViewController ()<CDRTranslucentSideBarDelegate>
{
    CDRTranslucentSideBar *_sideBar;     //左侧栏
    NSMutableArray  *dataSource;  //获取招标列表
    
}

@end

@implementation BiddingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self RegistSideBar];
    dataSource = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    self.title=@"招标";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showsideBar)];
    
    _myTableview=[UITableView newAutoLayoutView];
    _myTableview.tag=1001;
    _myTableview.delegate=self;
    _myTableview.dataSource=self;
    [self.view addSubview:_myTableview];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];


}

-(void)createData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFHTTPRequestOperation *op = [manager POST:TTBiddingLsitUrl parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr;
        arr=responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
            _biddingModel=[MTLJSONAdapter modelOfClass:[TTBiddingModel class] fromJSONDictionary:dic error:nil];
            [dataSource addObject:_biddingModel];
        }
        
        [_myTableview reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    [op start];
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
    if (tableView.tag==1001) {
        return 1;
    }
    else{
    return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1001) {
        return dataSource.count;
    }
    else{
    if (section == 0) {
        return 1;
    } else if (section == 1)
    {
        return 2;
    }
    
    }
    return 0;
   
        
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1001) {
        return 0;
    }
    else
    {
    if (section == 0) {
        // StatuBar Height
        return 20;
    } else if (section == 1) {
        return 44;
    }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1001) {
        
    }
    else{
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
        label.text = @"分类";
        [headerView addSubview:label];
        return headerView;
    }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1001) {
        return 50;
    }
    else{
    if (indexPath.section == 0) {
        return 0;
    } else if (indexPath.section == 1) {
        return 44;
    }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1001) {
        static NSString *cellID=@"biddingcell";
        BiddinglistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[BiddinglistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.biddingModel=dataSource[indexPath.row];
        cell.titleLab.text=cell.biddingModel.title_name;
       // cell.infoLab.text=biddinglist[indexPath.row][@"address"];
       
        
        return cell;
        
    }
    else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.section == 0) {
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"政府采购";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"企业投标";
        }
    }
        return cell;
    }
    return nil;
    
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

-(void)viewWillAppear:(BOOL)animated{
    [self createData];
}




@end
