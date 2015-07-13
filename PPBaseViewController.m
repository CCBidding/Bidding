//
//  PPBaseViewController.m
//  招标
//
//  Created by ppan on 15/7/9.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPBaseViewController.h"

@interface PPBaseViewController ()

@end

@implementation PPBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }

    return self;
}

-(id)initWithTableViewOrNOt:(BOOL)haveTableView{

    self  = [super init];
    if (self) {
        
    }

    return self;
}

-(instancetype)init{

    self = [super init];
    if (self) {
        
    }

    return  self;
}

-(void)setUpUIWithTableOrNOt:(BOOL)haveTableView{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _haveBack = YES;
    _showNavi = YES;
    
    if (haveTableView) {
        _myTableView = [UITableView newAutoLayoutView];
        [self.view addSubview:_myTableView];
        _myTableView.delegate = (id<UITableViewDelegate>)self;
        _myTableView.dataSource = (id<UITableViewDataSource>)self;
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        
    }
}

-(void)viewWillAppear:(BOOL)animated{

    
}
-(void)viewWillDisappear:(BOOL)animated{


}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (_haveBack) {
        self.navigationItem.leftBarButtonItem = [self itemWithImage:[UIImage imageNamed:@"Icon_back.png"] action:^(id sender){
        
            [self returenBtnTapped:sender];
        }];
        
    }
    
    if (_showNavi) {//默认展示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }else{
    
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    }
    
    [self createUI];
    [self createData];
}
-(void)returenBtnTapped:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createUI{

}
-(void)createData{

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
