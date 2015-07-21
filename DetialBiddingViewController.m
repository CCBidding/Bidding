//
//  DetialBiddingViewController.m
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "DetialBiddingViewController.h"
#import "DetailBiddingTableViewCell.h"

@interface DetialBiddingViewController ()
{
    NSArray  *detailArr;   //详情数组
}
@end

@implementation DetialBiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    detailArr = @[@"项目名称",@"项目内容",@"投标时间",@"投标地点"];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    
    _myTableview=[UITableView newAutoLayoutView];
    _myTableview.tag=1001;
    _myTableview.delegate=self;
    _myTableview.dataSource=self;
    _myTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _myTableview.rowHeight = UITableViewAutomaticDimension;
    _myTableview.estimatedRowHeight = TTScreenWith*60/320; // 设置为一个接近“平均”行高的值
    [self.view addSubview:_myTableview];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_myTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return detailArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     

    static NSString *cellID=@"biddingcell";
    DetailBiddingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[DetailBiddingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [self configureCell:cell withIndexPath:indexPath];
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
        static NSString *identifier = @"biddingcell";
        DetailBiddingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DetailBiddingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [self configureCell:cell withIndexPath:indexPath];
        if(!_biddingModel){
            return TTScreenWith*60/320;
        }
        else{
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
            return height;
        }
        

    return TTScreenWith*60/320;
}


- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    
    DetailBiddingTableViewCell *biddingcell = (DetailBiddingTableViewCell *)cell;
    biddingcell.titleLab.text    = detailArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
            biddingcell.infoLab.text = _biddingModel.project_name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            biddingcell.infoLab.text = _biddingModel.project_situation;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            biddingcell.infoLab.text = _biddingModel.oppen_time;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            biddingcell.infoLab.text = _biddingModel.address;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
}


@end
