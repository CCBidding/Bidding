//
//  PPAboutUsViewController.m
//  招标
//
//  Created by ppan on 15/7/16.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPAboutUsViewController.h"

@interface PPAboutUsViewController ()
{

    UIWebView *webView;
}
@end

@implementation PPAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI{

    webView = [UIWebView newAutoLayoutView];
    [self.view addSubview:webView];
    [webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];

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
