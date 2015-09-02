//
//  PPGadeViewController.m
//  招标
//
//  Created by ppan on 15/7/20.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPGadeViewController.h"

@interface PPGadeViewController ()<UITableViewDataSource,UITableViewDelegate,httpRequestDelegate>
{

    UITableView *myTableView;
   
    NSMutableDictionary  *dict;
    BOOL     isSelect;
    NSMutableArray     *isSelectGradeArr;
    NSMutableArray    *returnArr;
   
}
@end

@implementation PPGadeViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    for (NSString *pid in _pidArr) {
        dict = [[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *dic = @{@"type":@"grade",@"pid":pid};
        AFHTTPRequestOperation *op = [manager GET:TTGetGradeURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary  *diction = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            [dict setObject:diction[@"datas"] forKey:pid];
            [dict setObject:pid forKey:@"pid"];
            
            [myTableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [ MBProgressHUD showError:@"获取数据失败" toView:myTableView];
        }];
        
        op.responseSerializer = [AFHTTPResponseSerializer serializer];
        [op start];
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    isSelect = YES;
}

- (void)createUI{

    myTableView = [UITableView newAutoLayoutView];
    [self.view addSubview:myTableView];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    //myTableView.allowsSelection = YES;
    myTableView.allowsMultipleSelection = NO;
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(succeedWithItem:)];
    self.navigationItem.rightBarButtonItem = item;

}
/**
 *  完成按钮事件
 */
- (void)succeedWithItem:(UIBarButtonItem *)item{

    if (isSelect) {
        
        [myTableView setEditing:YES animated:YES];
       
        [item setTitle:@"完成"];
        
    }else{
        
        for (NSString *pid in self.pidArr) {
            NSMutableDictionary *dicions = [[NSMutableDictionary alloc]init];

             [dicions setObject:pid forKey:@"pro_id"];
            NSArray *arr = dict [pid];
            if (arr.count>0) {
                for (NSDictionary *dicion in arr) {
                    
                    NSString * grade = dicion[@"qu_id"];
                    int fen = grade.intValue;
                    for(int i= 0;i<isSelectGradeArr.count;i++){
                    
                        NSString *idt = isSelectGradeArr[i][@"qu_id"];
                        int sum = idt.intValue;
                        if (fen == sum ) {
                            
                            [dicions setObject:grade forKey:@"qu_id"];
                        }
                    }
                }
                
                
            }else{
            
               
                [dicions setObject:@"" forKey:@"gr_id"];
            
            }
            NSMutableArray *ar = [[NSMutableArray alloc]init];
            for (NSString *string in self.stringArr) {
                
                [ar addObject:string];
               
            }
            [dicions setObject:ar forKey:@"string"];
            [returnArr addObject:dicions];
        }
        
        [myTableView setEditing:NO animated:YES];
      
        if (isSelectGradeArr.count > 0){
        [self dismissVCWith:returnArr];
        }
        
       [item setTitle:@"选择"];
        

    }
    
    
    isSelect = !isSelect;

}

/**
 *  消失界面
 */

- (void)dismissVCWith:(NSArray *)arr{

    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
  
    NSDictionary *dic = @{@"arr":arr,@"isCompany":self.isCompany,@"string":_stringArr};
    [noti postNotificationName:@"isSelectArr" object:self userInfo:dic];
    [self getMessage];
    //[self modifyMessageWithChoose:arr andIsCompany:self.isCompany];
  

}

- (void)modifyMessageWithChoose:(NSArray *)arr  andIsCompany :(NSString *)company  withDiction:(NSMutableDictionary*)reqdiction {
    httpRequestViewController *request = [[httpRequestViewController alloc]init];
    request.delegate = self;
  
    
    //判断是公司资质修改还是人员资质修改
    if ([company isEqualToString:@"company"]) {
        NSString *name = [TTUserDefaultTool objectForKey:TTusername];
        
        for (int i=1; i<=arr.count; i++) {
            
            NSDictionary *diction = arr[i-1];
            NSString *pro = [NSString stringWithFormat:@"pro_id%d",i];
            NSString *qu = [NSString stringWithFormat:@"qu_id%d",i];
            [reqdiction setObject:diction[@"pro_id"] forKey:pro];
            [reqdiction setObject:diction[@"qu_id"] forKey:qu];
        }
        [reqdiction setObject:name forKey:@"username"];
        [reqdiction setObject:@"" forKey:@"duty_name"];
        [reqdiction setObject:@"" forKey:@"mainsuc"];
        [reqdiction setObject:@"" forKey:@"cname"];
        
       
        [request onSearch:TTModiFyMessageURL withDic:reqdiction];
    }
   
    if ([company isEqualToString:@"head"]) {
        NSString *name = [TTUserDefaultTool objectForKey:TTusername];
        
        for (int i=1; i<=arr.count; i++) {
            
            NSDictionary *diction = arr[i-1];
            NSString *pro = [NSString stringWithFormat:@"dpro_id%d",i];
            NSString *qu = [NSString stringWithFormat:@"dqu_id%d",i];
            [reqdiction setObject:diction[@"pro_id"] forKey:pro];
            [reqdiction setObject:diction[@"qu_id"] forKey:qu];
        }
        [reqdiction setObject:name forKey:@"username"];
        [reqdiction setObject:@"" forKey:@"duty_name"];
        [reqdiction setObject:@"" forKey:@"mainsuc"];
        [reqdiction setObject:@"" forKey:@"cname"];
        
        [request onSearch:TTModiFyMessageURL withDic:reqdiction];
        
    }


}

- (void)getMessage {
    httpRequestViewController *request;
    if (request == nil) {
       request = [[httpRequestViewController alloc]init];
    }
    request.delegate = self;
    NSString *userName = [TTUserDefaultTool objectForKey:TTusername];
    NSDictionary *dic = @{@"username":userName};
    [request onSearch:TTGetMessageURL withDic:dic];


}


- (void)didReciveDataWithDic:(NSDictionary *)result andRequestUrl:(NSString *)url {

    if ([url isEqualToString:TTGetMessageURL]) {
      
        NSArray *arr = result[@"datas"];
        NSArray  *arrcomcount = arr[2][@"compro"];
        NSArray  *arrusercount = arr[4][@"userpro"];
        NSMutableDictionary *dictionRequet = [[NSMutableDictionary alloc]init];
        if ([self.isCompany isEqualToString:@"company"]) {
            
            for (int i = 1; i <= arrusercount.count; i++) {
                
                NSString *pro = [NSString stringWithFormat:@"dpro_id%d",i];
                NSString  *qu = [NSString stringWithFormat:@"dqu_id%d",i];
                NSDictionary *arr = arrusercount[i-1];
                [dictionRequet setObject:arr[@"dpro_id"] forKey:pro];
                [dictionRequet setObject:arr[@"dqu_id"] forKey:qu];
            }
            
            [self modifyMessageWithChoose:returnArr andIsCompany:self.isCompany withDiction:dictionRequet];
        }
        
        if ([self.isCompany isEqualToString:@"head"]) {
            
            for (int i = 1; i <= arrusercount.count; i++) {
                
                NSString *pro = [NSString stringWithFormat:@"pro_id%d",i];
                NSString  *qu = [NSString stringWithFormat:@"qu_id%d",i];
                NSDictionary *dic = arrcomcount[i-1];
                [dictionRequet setObject:dic[@"pro_id"] forKey:pro];
                [dictionRequet setObject:dic[@"qu_id"] forKey:qu];
            }
            
            [self modifyMessageWithChoose:returnArr andIsCompany:self.isCompany withDiction:dictionRequet];

        }
        
    }
    if ([url isEqualToString:TTModiFyMessageURL]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    

}

- (void)createData{

    self.title = @"请选择您资质的等级";
    isSelectGradeArr = [[NSMutableArray alloc]init];
    returnArr = [[NSMutableArray alloc]init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _pidArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *arr = [dict objectForKey:_pidArr[section]];
    return arr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *arr = [dict objectForKey:_pidArr[indexPath.section]];
    NSString *title = [_stringArr[indexPath.section] stringByAppendingString:arr[indexPath.row][@"grade"]];
    cell.textLabel.text = title ;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return _stringArr[section];

}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.allowsSelectionDuringEditing = YES;
    return  UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSMutableArray *arr = [dict objectForKey:_pidArr[indexPath.section]];
    
    [isSelectGradeArr addObject:arr[indexPath.row]];
  
  
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{


}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    [_pidArr removeAllObjects];
    [_stringArr removeAllObjects];

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
