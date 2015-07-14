//
//  BiddingListViewController.m
//  招标
//
//  Created by mac chen on 15/7/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "BiddingListViewController.h"
#import "BiddinglistTableViewCell.h"
#import "DHMenuPagerViewController.h"
#import "DetialBiddingViewController.h"

@interface BiddingListViewController ()
{
    NSMutableArray  *dataSource;  //获取招标列表
    
}

@end

@implementation BiddingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     dataSource = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    
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
        arr = responseObject[@"datas"];
        if (dataSource != 0) {
            [dataSource removeAllObjects];
        }
        
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


// This is just a sample for tableview menu
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1001) {
        return 1;
    }
    else{
    return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1001) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"infoCell";
    BiddinglistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BiddinglistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self configureCell:cell withIndexPath:indexPath];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetialBiddingViewController *detailVC = [[DetialBiddingViewController alloc]init];
    detailVC.showNavi = YES;
    detailVC.haveBack = YES;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detailVC];
    static NSString *cellID=@"biddingcell";
    BiddinglistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[BiddinglistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    detailVC.biddingModel=dataSource[indexPath.row];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static NSString *cellID=@"biddingcell";
        BiddinglistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[BiddinglistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
       [self configureCell:cell withIndexPath:indexPath];
    
        
        return cell;
        

}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
   
        BiddinglistTableViewCell *biddingcell = (BiddinglistTableViewCell *)cell;
        biddingcell.biddingModel    = dataSource[indexPath.row];
        biddingcell.titleLab.text   = biddingcell.biddingModel.title_name;
        biddingcell.addressLab.text = biddingcell.biddingModel.address;
        biddingcell.timeLab.text   = biddingcell.biddingModel.oppen_time;
  
}

-(void)viewWillAppear:(BOOL)animated{
  
    [self createData];
}




@end
