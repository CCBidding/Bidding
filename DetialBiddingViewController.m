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
    NSString *mainUrl;     //主页
}
@end

@implementation DetialBiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    if (_detailBidType == detailbidTypeBidding) {
         detailArr = @[@"标题",@"项目编号",@"项目名称",@"项目简介",@"发布日期",@"代理机构",@"项目负责人",@"联系方式",@"详细网址"];
    }
    else{
        detailArr = @[@"采购标题",@"采购人",@"项目名称",@"项目编号",@"项目序列",@"采购方式",@"采购公告",@"评审信息",@"定标日期",@"中标信息",@"联系事项",@"详细网址"];
    }
   
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
        if(!_biddingModel||!_winBiddingModel){
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
    if (_detailBidType == detailbidTypeBidding) {
        switch (indexPath.row) {
            case 0:
                biddingcell.infoLab.text = _biddingModel.title_name;
        
                break;
            case 1:
                biddingcell.infoLab.text = _biddingModel.project_id;
                
                break;
            case 2:
                biddingcell.infoLab.text = _biddingModel.project_name;
               
                break;
            case 3:
                biddingcell.infoLab.text = _biddingModel.project_situation;
              
                break;
            case 4:
                biddingcell.infoLab.text = _biddingModel.oppen_time;
                
                break;
            case 5:
                biddingcell.infoLab.text = _biddingModel.address;
       
                break;
            case 6:
                biddingcell.infoLab.text = _biddingModel.contact_name;
             
                break;
            case 7:
                biddingcell.infoLab.text = _biddingModel.contact_info;
                
                break;
            case 8:
                biddingcell.infoLab.text = _biddingModel.url;
                mainUrl = _biddingModel.url;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }

    }
    else{
        switch (indexPath.row) {
            case 0:
                biddingcell.infoLab.text = _winBiddingModel.title_name;
        
                break;
            case 1:
                biddingcell.infoLab.text = _winBiddingModel.caigourenName;
             
                break;
            case 2:
                biddingcell.infoLab.text = _winBiddingModel.xiangmuName;
               
                break;
            case 3:
                biddingcell.infoLab.text = _winBiddingModel.xiangmuNum;
       
                break;
            case 4:
                biddingcell.infoLab.text = _winBiddingModel.xiangmuxulieNum;
            
                break;
            case 5:
                biddingcell.infoLab.text = _winBiddingModel.caigoufangshi;
                
                break;
            case 6:
                biddingcell.infoLab.text = _winBiddingModel.caigougonggaoriqijiMeiti;
           
                break;
            case 7:
                biddingcell.infoLab.text = _winBiddingModel.pingshenxinxi;
           
                break;
            case 8:
                biddingcell.infoLab.text = _winBiddingModel.dingbiaoriqi;
            
                break;
            case 9:
                biddingcell.infoLab.text = _winBiddingModel.zhongbiaoxinxi;

                break;
            case 10:
                biddingcell.infoLab.text = _winBiddingModel.lianxishixiang;
                break;
            case 11:
                biddingcell.infoLab.text = _winBiddingModel.url;
                mainUrl = _winBiddingModel.url;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
 
    
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == (detailArr.count-1)){
        TTBaseWebViewController *webVC;
        if (!webVC) {
            webVC = [[TTBaseWebViewController alloc]init] ;
        }
        webVC.haveBack = YES;
        webVC.showNavi = YES;
        webVC.mainUrl  = mainUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    
    }

}



@end
