//
//  PPChooseInfoViewController.m
//  招标
//
//  Created by ppan on 15/7/17.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPChooseInfoViewController.h"
#import "PinyinHelper.h"
#import "PPResultViewController.h"
@interface PPChooseInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>
{

    UITableView          *myTableView;
    NSMutableArray *dataArr;
    NSArray  *newDataArr; //排序后的数组
    NSArray *keys;
    NSDictionary *titleDic;
    NSMutableDictionary *sectionNum;
    
    UISearchController *mySearchController;
    BOOL  isSelect;
    NSMutableArray  *isSelectArr;
    NSMutableDictionary  *pidDic;
    NSMutableArray  *isSelectPidArr;
}
@end

@implementation PPChooseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资质选择";
}
- (void)createUI{

    
    myTableView = [UITableView newAutoLayoutView];
    [self.view addSubview:myTableView];
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    myTableView.delegate = (id<UITableViewDelegate>)self;
    myTableView.dataSource = (id<UITableViewDataSource>)self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.allowsSelection = YES;
    myTableView.showsHorizontalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.editing = NO;
    //设置索引列表文本的颜色
    myTableView.sectionIndexColor = [UIColor blueColor];
    
   
    PPResultViewController *result = [[PPResultViewController alloc]init];
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:result];
    
    mySearchController.searchResultsUpdater = result;
    mySearchController.dimsBackgroundDuringPresentation = YES;
    [mySearchController.searchBar sizeToFit];
    
    myTableView.tableHeaderView = mySearchController.searchBar;
    self.definesPresentationContext = YES;
   
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(chanageTableViewEditStyleWithBarItem:)];
    self.navigationItem.rightBarButtonItem = item;

}
/**
 *  从服务器获取资质数组
 */
- (void )getDataWithURL:(NSString *)urlStr{

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *op = [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = dic[@"datas"];
        
        for (NSDictionary *dic in arr) {
            
            NSString *str = dic[@"pro_name"];
            NSString *pidStr = dic[@"pro_id"];
            [pidDic setObject:pidStr forKey:str];
            [dataArr addObject:str];
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:dataArr forKey:@"data"];
        [userDefaults  synchronize];
        
        [ MBProgressHUD  hideHUDForView:myTableView animated:YES];
        [self sortArrWith:dataArr];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [ MBProgressHUD  hideHUDForView:myTableView animated:YES];
        [MBProgressHUD showError:@"获取数据失败" toView:myTableView];
       
    }];

    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];

}

- (void)createData{

    isSelect = YES;
    dataArr = [[NSMutableArray alloc]init];
    pidDic = [[NSMutableDictionary alloc]init];
    isSelectPidArr = [[NSMutableArray alloc]init];
    [self getDataWithURL:TTGetComtypeURL];
    newDataArr = [NSArray new];
    titleDic = [[NSDictionary alloc]init];
    isSelectArr = [[NSMutableArray alloc]init];
    sectionNum = [[NSMutableDictionary alloc]init];
    
    [MBProgressHUD showLoading:@"正在加载数据" toView:myTableView];
}
/**
 *  把数组里面内容按首字大写排序，提取大写字母作为索引
 *
 *  @param NSDictionary <#NSDictionary description#>
 *
 *  @return <#return value description#>
 */
- (void)sortArrWith:(NSMutableArray *)array{


    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
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
    
    keys = [[NSArray alloc]init];
    //创建26个可变数组
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (char character = 'A'; character < 'Z'; character++) {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [dic setObject:array forKey:[NSString stringWithFormat:@"%c",character]];
    }
    
    //将数据按拼音首字母分别放入数组
    for (NSString *info in array) {
        
        NSString *str = [PinyinHelper getFirstHanyuPinyinStringWithChar:[info characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
        
        NSRange range = NSMakeRange(0, 1);
        NSString *c = [str substringWithRange:range];
        
        NSString *inital = [NSString stringWithFormat:@"%@",c];
        NSMutableArray *array = [dic objectForKey:inital];
        [array addObject:info];
        
    }
    //将空组去掉
    for (char character = 'A'; character <= 'Z'; character++) {
        
        NSString *key = [NSString stringWithFormat:@"%c",character];
        NSArray *array = [dic objectForKey:key];
        if (!array.count) {
            [dic removeObjectForKey:key];
        }
    }
   
    keys = [dic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *number1 = obj1;
        NSString *number2 = obj2;
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
        
    }];


    [myTableView reloadData];
}

#pragma -mark 把数组中首字母一样的归为一类
- (NSDictionary *)combineWithFirst:(NSArray *)arr  withKeys:(NSArray *)keysArr{
    
    
   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   
    for (NSString *st in keysArr) {
         NSMutableArray *arra = [[NSMutableArray alloc ]init];
        for (int i= 0; i<arr.count; i++) {
            NSString *str = [PinyinHelper getFirstHanyuPinyinStringWithChar:[arr[i] characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
            NSRange range = NSMakeRange(0, 1);
            NSString *c = [str substringWithRange:range];

            if ([st isEqualToString:c]) {
                
                [arra addObject:arr[i]];
                
            }
            
        }
        
        [dic setObject:arra forKey:st];
        
    }

    return dic;

}
#pragma -mark 改变tabliew 编辑模式
- (void)chanageTableViewEditStyleWithBarItem:(UIBarButtonItem *)item{

    
    if (isSelect) {
        
        [myTableView setEditing:YES animated:YES];
        [item setTitle:@"下一步"];
       
    }else{
    
    
        [myTableView setEditing:NO animated:YES];
        //当选择对象时，才跳转到下一个界面
        if (isSelectArr.count>0) {
            [self dissmisController];
        }else{
        
            [MBProgressHUD showError:@"请至少选择一个资质" toView:myTableView];
        
        }
        
        [item setTitle:@"选择"];
    }
    
    
    isSelect = !isSelect;

}
#pragma -mark 消失
- (void)dissmisController{

       
    PPGadeViewController *gradeVC = [[PPGadeViewController alloc]init];
    gradeVC.haveBack = YES;
    gradeVC.showNavi = YES;
    gradeVC.pidArr = isSelectPidArr;
    gradeVC.stringArr = isSelectArr;
    gradeVC.isCompany = self.isCompany;
    [self.navigationController pushViewController:gradeVC animated:YES];
  

    
}

#pragma -mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    titleDic  = [self combineWithFirst:dataArr withKeys:keys];
    NSArray *array = [[NSArray alloc]init];
    array = [titleDic objectForKey:keys[section]];
    return array.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (! cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *arr = [titleDic objectForKey:keys[indexPath.section]];
    
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    tableView.allowsMultipleSelectionDuringEditing = YES;
    return  UITableViewCellEditingStyleDelete ;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (myTableView.allowsMultipleSelectionDuringEditing) {
        
        NSArray *arr = [titleDic objectForKey:keys[indexPath.section]];
        
        NSString *string = arr[indexPath.row];
        
        NSString *pidStr = [pidDic objectForKey:string];
        [isSelectPidArr addObject:pidStr];
        [isSelectArr addObject:arr[indexPath.row]];
        
    }
   

}
#pragma -mark 添加索引列

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return keys;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [keys objectAtIndex:section];
}

//#pragma -mark searchBar delegate
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    NSString *filterString = searchController.searchBar.text;
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
//    
//    dataArr = [NSMutableArray arrayWithArray:[dataArr filteredArrayUsingPredicate:predicate]];
//  
//    
//    [self.myTableView reloadData];
//}

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
