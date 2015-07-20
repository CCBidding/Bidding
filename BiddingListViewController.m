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
    NSString        *requestUrl;  //请求URL
    
}
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation BiddingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     dataSource = [[NSMutableArray alloc]init];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    if (_bidsType==bidTypeBidding) {
        self.title = @"招标";
    }
    else{
        self.title = @"中标";
    }

}

-(void)createUI{

    _myTableview = [UITableView newAutoLayoutView];
    _myTableview.tag        = 1001;
    _myTableview.delegate   = self;
    _myTableview.dataSource = self;
    _myTableview.rowHeight  = 60.0f;
     _myTableview.separatorColor = [UIColor whiteColor];
    [self.view addSubview:_myTableview];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self setupHeader];
    [self setupFooter];
}

-(void)createData{
    if (_bidsType==bidTypeBidding) {
        requestUrl=TTBiddingLsitUrl;
    }
    else{
        requestUrl=TTBidWinlistUrl;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFHTTPRequestOperation *op = [manager POST:requestUrl parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:_myTableview];
    _refreshHeader = refreshHeader;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self createData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 动画view
    UIImageView *animationView =[UIImageView newAutoLayoutView];
    [refreshHeader addSubview:animationView];
    [animationView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [animationView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-TTScreenWith/3];
    [animationView autoSetDimensionsToSize:CGSizeMake(40, 40)];
    animationView.image = [UIImage imageNamed:@"staticDeliveryStaff"];
       _animationView = animationView;

    UILabel *label= [UILabel newAutoLayoutView];
    [refreshHeader addSubview:label];
    label.text = @"下拉加载最新数据";
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-TTScreenWith/4-5];
    [label autoSetDimensionsToSize:CGSizeMake(200, 20)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    _label = label;
    
    // normal状态执行的操作
    refreshHeader.normalStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        refreshView.hidden = NO;
        if (progress == 0) {
            _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _boxView.hidden = NO;
            _label.text = @"下拉加载最新数据";
            [_animationView stopAnimating];
        }
        
        self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
        self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 90, progress * 35);
    };
    
    // willRefresh状态执行的操作
    refreshHeader.willRefreshStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _boxView.hidden = YES;
        _label.text = @"放开我，我要为你加载数据";
        _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
        NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                            [UIImage imageNamed:@"deliveryStaff1"],
                            [UIImage imageNamed:@"deliveryStaff2"],
                            [UIImage imageNamed:@"deliveryStaff3"]
                            ];
        _animationView.animationImages = images;
        [_animationView startAnimating];
    };
    
    // refreshing状态执行的操作
    refreshHeader.refreshingStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _label.text = @"客观别急，正在加载数据...";
        [UIView animateWithDuration:1.5 animations:^{
            self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
        }];
    };
    
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:_myTableview];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createData];
        [self.refreshFooter endRefreshing];
    });
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
    
    return 80;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetialBiddingViewController *detailVC = [[DetialBiddingViewController alloc]init];
    detailVC.showNavi = YES;
    detailVC.haveBack = YES;
    static NSString *cellID = @"biddingcell";
    BiddinglistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[BiddinglistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    detailVC.biddingModel=dataSource[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static NSString *cellID = @"biddingcell";
        BiddinglistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[BiddinglistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
       [self configureCell:cell withIndexPath:indexPath];
    
        return cell;
        

}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
   
        BiddinglistTableViewCell *biddingcell = (BiddinglistTableViewCell *)cell;
        biddingcell.biddingModel              = dataSource[indexPath.row];
        biddingcell.infoLab.text              = biddingcell.biddingModel.title_name;
        biddingcell.addressLab.text           = biddingcell.biddingModel.address;
        biddingcell.timeLab.text              = biddingcell.biddingModel.oppen_time  ;
  
}

-(void)viewWillAppear:(BOOL)animated{
  
    [self createData];
   
}





@end
