//
//  XXPageChildViewController.h
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPageChildViewController : UIViewController
{
    NSString *alias;
}
@property(nonatomic, strong) NSString *alias;

+ (instancetype)CreateViewControllerWithAlias:(NSString *)string;
@end
