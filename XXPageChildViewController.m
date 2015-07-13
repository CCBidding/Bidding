//
//  XXPageChildViewController.m
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import "XXPageChildViewController.h"

@interface XXPageChildViewController ()

@end

@implementation XXPageChildViewController
@synthesize alias;

- (id)initWithAlias:(NSString *)string nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        alias = string;
    }
    return self;
}

+ (instancetype)CreateViewControllerWithAlias:(NSString *)string
{
    XXPageChildViewController *vc = [[XXPageChildViewController alloc] initWithAlias:string
                                                                             nibName:nil
                                                                              bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.font = [UIFont boldSystemFontOfSize:35.0f];
    [self.view addSubview:centerLabel];
    centerLabel.text = alias;
    [centerLabel sizeToFit];
    centerLabel.center = self.view.center;
    centerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
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
