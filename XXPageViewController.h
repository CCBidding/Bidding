//
//  XXPageViewController.h
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXPageSelectorView.h"

//Number of pages
typedef NSUInteger(^NumberOfPagesBlock)(void);
//Content view controller at specified index
typedef UIViewController*(^ViewControllerAtIndexBlock)(NSUInteger index);
//Title for bar item at specified index
typedef NSString*(^TitleForPageAtIndexBlock)(NSUInteger index);


@interface XXPageViewController : UIViewController

@property(nonatomic, strong) NSMutableArray *subviewControllers;
@property(nonatomic, assign) NSInteger selectedIndex;
// Datasource related blocks
@property(nonatomic, copy) NumberOfPagesBlock block_numberOfPages;
@property(nonatomic, copy) ViewControllerAtIndexBlock block_viewControllerAtIndex;
@property(nonatomic, copy) TitleForPageAtIndexBlock block_titleForPageAtIndex;

- (void)reloadData;
@end

