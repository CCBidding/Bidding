//
//  HomeViewController.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    UIImageView *backgroundImage;//背景图片
    UITextField *namefield;
    UITextField *pwfield;

}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];

    
}
-(void)creatUI{
    backgroundImage=[UIImageView newAutoLayoutView];
      [self.view addSubview:backgroundImage];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [backgroundImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [backgroundImage  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
     [self SetObfuscationImageView:backgroundImage AndIcon:@"backImage1"];
 
   


}

#pragma 设置模糊化图片
-(void)SetObfuscationImageView:(UIImageView *)imageview AndIcon:(NSString *)Icon{

    [imageview setImageToBlur:[UIImage imageNamed:Icon]
                   blurRadius:20.0   completionBlock:^(NSError *error){
                   }];
}


@end
