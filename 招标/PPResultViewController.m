//
//  PPResultViewController.m
//  招标
//
//  Created by ppan on 15/7/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPResultViewController.h"

@interface PPResultViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *myTableView;
    NSArray   *origailArr;
    NSMutableArray   *searchArr;

}

@end

@implementation PPResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI{

    myTableView = [UITableView newAutoLayoutView];
    [self.view addSubview:myTableView];
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    myTableView.delegate = self;
    myTableView.dataSource = self;

}

- (void)createData{
    
    origailArr = [[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    origailArr = [defaults arrayForKey:@"data"];
    origailArr = [origailArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *string1 = obj1;
        NSString *str1 = [PinyinHelper getFirstHanyuPinyinStringWithChar:[string1 characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
        NSRange range = NSMakeRange(0, 1);
        NSString *c1 = [str1 substringWithRange:range];
        
        NSString *string2 = obj2;
        NSString *str2 = [PinyinHelper getFirstHanyuPinyinStringWithChar:[string2 characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
        
        NSString *c2 = [str2 substringWithRange:range];
        NSComparisonResult result = [c1 compare:c2];
        
        return result == NSOrderedDescending; // 升序
        
    }];
    
    searchArr = [[NSMutableArray alloc]init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (searchArr.count > 0) {
        return searchArr.count;
    }else
    
    return origailArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (searchArr.count > 0) {
        
        cell.textLabel.text = searchArr[indexPath.row];
    }
    else
    cell.textLabel.text = origailArr[indexPath.row];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
   NSString *string1 = searchController.searchBar.text;
    if (![string1 isEqualToString:@""]) {
        NSString *str1 = [PinyinHelper getFirstHanyuPinyinStringWithChar:[string1 characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
        NSRange range = NSMakeRange(0, 1);
        NSString *c1 = [str1 substringWithRange:range];
        
        for (NSString *str in origailArr) {
            NSString *string = [PinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
            
            NSRange range = NSMakeRange(0, 1);
            NSString *c2 = [string substringWithRange:range];
            
            if ([c1 isEqualToString:c2]) {
                [searchArr addObject:str];
                
            }
        }
        
        [myTableView reloadData];
        
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *arr = [NSArray arrayWithObject:searchArr[indexPath.row]];
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = @{@"arr":arr};
    [noti postNotificationName:@"isSelectArr" object:self userInfo:dic];
    
    [self.navigationController popViewControllerAnimated:YES];



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
