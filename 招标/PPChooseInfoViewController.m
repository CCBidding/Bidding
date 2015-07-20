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
@interface PPChooseInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{

    UITableView *myTableView;
    NSMutableArray *dataArr;
    NSArray  *newDataArr; //排序后的数组
    NSArray *keys;
    NSDictionary *titleDic;
    NSMutableDictionary *sectionNum;
    
    UISearchController *mySearchController;
    BOOL  isSelect;
    NSMutableArray  *isSelectArr;
}
@end

@implementation PPChooseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    myTableView.allowsMultipleSelection = YES;
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

- (void)createData{

    isSelect = YES;
    dataArr = [NSMutableArray arrayWithObjects:@"工程招标代理甲级",@"工程招标代理乙级",@"中央投资项目招标代理预备级",@"政府采购甲级",@"市政行业甲级",@"建筑行业甲级",@"房屋建筑工程施工总承包特级",@"公路工程一级",@"矿山工程一级",@"市政公用工程一级",@"钢结构工程一级",@"消费设施工程一级",@"建筑防水工程二级",@"建筑装修装饰工程一级",@"建筑装修装饰工程一级",@"机电安装工程二级",@"机电设备安装工程一级"
               ,@"防腐保温工程一级",@"店里工程二级",@"水利水电工程三级",@"化工石油设备管道安装一级",@"城市及道路照明工程一级",@"送变电工程一级",@"建筑幕墙工程一级",@"工程造价咨询企业甲级",@"项目管理乙级",nil];

    newDataArr = [NSArray new];
    titleDic = [[NSDictionary alloc]init];
    isSelectArr = [[NSMutableArray alloc]init];
    sectionNum = [[NSMutableDictionary alloc]init];
    [dataArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
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
    for (NSString *info in dataArr) {
    
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
    NSLog(@"count:%lu",(unsigned long)dic.allKeys.count);
    keys = [dic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *number1 = obj1;
        NSString *number2 = obj2;
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
       
    }];
    
}

#pragma -mark 把数组中首字母一样的归为一类
- (NSDictionary *)combineWithFirst:(NSArray *)arr  withKeys:(NSArray *)keysArr{
    
    
   NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
   
//    for (NSString *string in arr) {
//        
//        NSString *str = [PinyinHelper getFirstHanyuPinyinStringWithChar:[string characterAtIndex:0] withHanyuPinyinOutputFormat:nil];
//        NSRange range = NSMakeRange(0, 1);
//        NSString *c = [str substringWithRange:range];
//        for (int i = 0; i < keysArr.count; i++) {
//          
//            if ([c isEqualToString: keysArr[i]]) {
//                
//                [arra addObject:string];
//               
//            }
//        }
//       
//        [dic setObject:arr forKey:c];
//    }
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
        [item setTitle:@"确定"];
       
    }else{
    
    
        [myTableView setEditing:NO animated:YES];
        [self dissmisController];
        [item setTitle:@"选择"];
    }
    
    
    isSelect = !isSelect;

}
#pragma -mark 消失
- (void)dissmisController{

    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = @{@"arr":isSelectArr};
    [noti postNotificationName:@"isSelectArr" object:self userInfo:dic];
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma -mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    NSDictionary *dic = [[NSDictionary alloc]init];
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    dic = [self combineWithFirst:dataArr withKeys:keys];
//
//    NSArray *valuesArr = [dic allValues];
//
//   
//    
//    for (NSString *str in valuesArr) {
//        
//        if ([str isEqualToString:keys[section]]) {
//            
//            [array addObject:str];
//        }
//    }
//    NSString *sect = [NSString stringWithFormat:@"%ld",(long)section];
//    [sectionNum setObject:array forKey:sect];
    
   
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
    
    //
 
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    tableView.allowsMultipleSelectionDuringEditing = YES;
    return  UITableViewCellEditingStyleDelete;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [titleDic objectForKey:keys[indexPath.section]];
    
    //cell.textLabel.text = arr[indexPath.row];

    [isSelectArr addObject:arr[indexPath.row]];

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
