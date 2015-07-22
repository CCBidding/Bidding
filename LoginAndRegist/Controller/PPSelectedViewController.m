//
//  PPSelectedViewController.m
//  招标
//
//  Created by ppan on 15/7/21.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPSelectedViewController.h"

@interface PPSelectedViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *myTableView;
    PPGuideUserView *guideView;
}
@end

@implementation PPSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    
}


- (void)createUI{

    myTableView = [UITableView newAutoLayoutView];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backImage2"]];
    [self.view addSubview:imageV];
    [self.view addSubview:myTableView];
    [myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    myTableView.alpha = 0.55;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTableView bk_whenTapped:^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    [self createAnimalGradeUserActionToView:self.view];
}

- (void)createAnimalGradeUserActionToView:(UIView *)view{
    
    
    
    CGRect rect = CGRectMake(TTScreenWith/3, TTScreenHeight/4, 150.0f, 35.0f);
    
    guideView = [[PPGuideUserView alloc]initWithFrame:rect backImage:[UIImage imageNamed:@"change_search_tip.png"] msgStr:@"轻拍消失" txtColor:[colorTurn RGBColorFromHexString:@"#ffffff" alpha:1.0f]];
    
    [myTableView addSubview:guideView];
    
    CABasicAnimation *jumpAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    jumpAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    jumpAnimation.toValue = [NSNumber numberWithFloat:10.0f];
    
    jumpAnimation.duration = 0.5f;//动画持续时间
    jumpAnimation.repeatCount = 10;//动画重复次数
    jumpAnimation.autoreverses = YES;//是否自动重复
    [guideView.layer addAnimation:jumpAnimation forKey:@"animateLayer"];
    
    [self performSelector:@selector(removeViewWithView) withObject:self afterDelay:3];
    
    
}
- (void)removeViewWithView {
    
    [guideView removeFromSuperview];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataArr[indexPath.row][@"string"][indexPath.row];

    cell.backgroundColor = [UIColor clearColor];
    return cell;
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
