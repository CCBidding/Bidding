//
//  RegistViewController.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
{
    UIImageView *backgroundImage;//背景图片


}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)creatUI{
    backgroundImage=[UIImageView newAutoLayoutView];
    UIImage *img=[[UIImage alloc]init];
    backgroundImage.image= [img getBlurImage:[UIImage imageNamed:@"backImage2"]];
    backgroundImage.userInteractionEnabled=YES;
    [backgroundImage bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
    [self.view addSubview:backgroundImage];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [backgroundImage  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];


}


@end
