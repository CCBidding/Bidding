//
//  httpRequestViewController.m
//  招标
//
//  Created by ppan on 15/8/10.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "httpRequestViewController.h"

@interface httpRequestViewController ()

@end

@implementation httpRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onSearch:(NSString *)url  withDic:(NSDictionary *)dic{

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *op = [manger GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.delegate didReciveDataWithDic:dic
                              andRequestUrl:url];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"ero:%@",error);
        
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];


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
