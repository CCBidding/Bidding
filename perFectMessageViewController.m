//
//  perFectMessageViewController.m
//  
//
//  Created by ppan on 15/8/31.
//
//

#import "perFectMessageViewController.h"

@interface perFectMessageViewController ()<UITableViewDataSource,UITableViewDelegate,httpRequestDelegate>
{

    UITableView  *myTableView;
    NSArray      *data;
    NSMutableArray      *messageData;
}
@end

@implementation perFectMessageViewController

static perFectMessageViewController *perController;
+ (perFectMessageViewController *)shareInstance {


    if (!perController) {
        
        perController = [[perFectMessageViewController alloc]init];
    }
    
    return perController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI {

    myTableView = [[UITableView alloc]init];
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        
    }];
    myTableView.delegate = self;
    myTableView.dataSource = self;

}

- (void)createData {

    data = @[@"用户名",@"公司资质",@"负责人资质"];
    messageData = [[NSMutableArray alloc]init];
    httpRequestViewController *requestController = [[httpRequestViewController alloc]init];
    requestController.delegate = self;
    NSString *userName = [TTUserDefaultTool objectForKey:TTusername];
    NSDictionary *dic = @{@"username":userName};
    [requestController onSearch:TTGetMessageURL withDic:dic];

}

- (void)didReciveDataWithDic:(NSDictionary *)result andRequestUrl:(NSString *)url {
 
  
    NSArray *arr = result[@"datas"];
    [messageData addObject:arr[0]];
    [messageData addObject:arr[2]];
    [messageData addObject:arr[4]];
    [myTableView reloadData];
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:{
        
            return 1;
        }
            break;
        case 1:{
            if (messageData.count > 0) {
                NSArray *arr = messageData[1][@"compro"];
                if (arr.count>0) {
                    
                    return arr.count;
                }
                else
                    return 1;
            }else
                return 1;
           
        }
            break;
        case 2:{
            if (messageData.count > 0) {
                NSArray *arr = messageData[2][@"userpro"];
                if (arr.count>0) {
                    
                    return arr.count;
                }
                else
                    return 1;
            }else
                return 1;
           
        }
            break;
            
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (messageData.count>0) {
        switch (indexPath.section) {
            case 0:
            {
                cell.detailTextLabel.text = messageData[indexPath.section][@"username"];
            }
                break;
            case 1:{
                NSArray *arr = messageData[indexPath.section][@"compro"];
                if (arr.count>0) {
                    cell.detailTextLabel.text = arr[indexPath.row][@"pro_name"];
                }
                
            }
                break;
            case 2: {
                NSArray *arrar = messageData[indexPath.section][@"userpro"];
                if (arrar.count>0) {
                     cell.detailTextLabel.text = arrar[indexPath.row][@"dpro_name"];
                }
               
            }
            default:
                break;
        }
 
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return data[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 1) {
//        
//        PPChooseInfoViewController *chose = [[PPChooseInfoViewController alloc]init];
//        chose.haveBack = YES;
//        chose.showNavi = YES;
//        chose.isCompany =@"company";
//        [self.navigationController pushViewController:chose animated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
