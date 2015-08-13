//
//  httpRequestViewController.h
//  招标
//
//  Created by ppan on 15/8/10.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol httpRequestDelegate

- (void)didReciveDataWithDic:(NSDictionary *)result andRequestUrl:(NSString *)url;

@end

@interface httpRequestViewController : UIViewController

@property(strong,nonatomic)id<httpRequestDelegate> delegate;
- (void)onSearch:(NSString *)url  withDic:(NSDictionary *)dic;
@end
