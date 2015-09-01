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
         detailArr = @[@"招标标题",@"招标条件",@"项目概况与招标范围",@"投标人资格要求",@"招标文件的获取",@"投标报名",@"投标文件的递交",@"发布公告的媒介",@"联系方式",@"其他事项",@"招标机构",@"发布招标消息时间",@"详细网址"];
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
        if(!(_biddingModel||_winBiddingModel)){
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
                biddingcell.infoLab.text = _biddingModel.bid_title;
        
                break;
            case 1:
                biddingcell.infoLab.text = _biddingModel.bid_condition;
                
                break;
            case 2:
                biddingcell.infoLab.text = _biddingModel.bid_survey;
               
                break;
            case 3:
                biddingcell.infoLab.text = _biddingModel.bid_qua;
              
                break;
            case 4:
                biddingcell.infoLab.text = _biddingModel.bid_obtain;
                
                break;
            case 5:
                biddingcell.infoLab.text = _biddingModel.bid_reg;
       
                break;
            case 6:
                biddingcell.infoLab.text = _biddingModel.bid_submit;
             
                break;
            case 7:
                biddingcell.infoLab.text = _biddingModel.bid_media;
                
                break;
            case 8:
                biddingcell.infoLab.text = _biddingModel.bid_contact;
               
                break;
            case 9:
                biddingcell.infoLab.text = _biddingModel.bid_other;
                
                break;
            case 10:
                biddingcell.infoLab.text = _biddingModel.org_name;
                
                break;
            case 11:
                biddingcell.infoLab.text = _biddingModel.org_putime;
                
                break;
            case 12:
                biddingcell.infoLab.text = _biddingModel.bid_url;
                mainUrl = _biddingModel.bid_url;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;




                
            default:
                break;
        }

    }
    else{
        switch (indexPath.row) {
            case 0:
                biddingcell.infoLab.text = _winBiddingModel.widTitle;
        
                break;
            case 1:
                biddingcell.infoLab.text = _winBiddingModel.bidOrg;
             
                break;
            case 2:
                biddingcell.infoLab.text = _winBiddingModel.bidOrg;
               
                break;
            case 3:
                biddingcell.infoLab.text = @"";
       
                break;
            case 4:
                biddingcell.infoLab.text = @"";
            
                break;
            case 5:
                biddingcell.infoLab.text = @"";
                
                break;
            case 6:
                biddingcell.infoLab.text =@"";
           
                break;
            case 7:
                biddingcell.infoLab.text = @"";
           
                break;
            case 8:
                biddingcell.infoLab.text = _winBiddingModel.oppenDate;
            
                break;
            case 9:
                biddingcell.infoLab.text = _winBiddingModel.widInfo;

                break;
            case 10:
                biddingcell.infoLab.text = _winBiddingModel.other;
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
