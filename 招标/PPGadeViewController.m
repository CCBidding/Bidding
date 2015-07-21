//
//  PPGadeViewController.m
//  招标
//
//  Created by ppan on 15/7/20.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPGadeViewController.h"

@interface PPGadeViewController ()<UITableViewDataSource,UITableViewDelegate>
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

//    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
//    NSDictionary *dic = @{@"arr":_isSelectArr,@"isCompany":self.isCompany,@"pidArr":isSelectPidArr};
//    [noti postNotificationName:@"isSelectArr" object:self userInfo:dic];
    if (isSelect) {
        
        [myTableView setEditing:YES animated:YES];
       
        [item setTitle:@"完成"];
        
    }else{
        
        for (NSString *pid in self.pidArr) {
            NSMutableDictionary *dicions = [[NSMutableDictionary alloc]init];

             [dicions setObject:pid forKey:@"pro"];
            NSArray *arr = dict [pid];
            if (arr.count>0) {
                for (NSDictionary *dicion in arr) {
                    
                    NSString * grade = dicion[@"id"];
                    int fen = grade.intValue;
                    for(int i= 0;i<isSelectGradeArr.count;i++){
                    
                        NSString *idt = isSelectGradeArr[i][@"id"];
                        int sum = idt.intValue;
                        if (fen == sum ) {
                            
                            [dicions setObject:grade forKey:@"grade"];
                        }
                    }
                }
                
                
            }else{
            
               
                [dicions setObject:@"" forKey:@"grade"];
            
            }
            [returnArr addObject:dicions];
        }
        
        [myTableView setEditing:NO animated:YES];
      
        NSLog(@"return:%@",returnArr);
        [item setTitle:@"选择"];
    }
    
    
    isSelect = !isSelect;

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
