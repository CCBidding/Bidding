

//
//  NavParentController.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/11.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "NavParentController.h"
#import "DHSlideMenuController.h"
#import "REFrostedViewController.h"
#import "UIViewController+REFrostedViewController.h"
@interface NavParentController ()
{
  
   REFrostedViewController *frostedViewController;

}

@end

@implementation NavParentController

- (void)loadView {
    [super loadView];
    self.navigationBar.translucent = NO;
  
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.frostedViewController panGestureRecognized:sender];
}

- (void)viewDidAppear:(BOOL)animated {
    for (UIViewController *vc in self.childViewControllers) {
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
        vc.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
        self.navigationBar.barTintColor=TTColor(255, 78, 78, 1);
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
       
    }
    
    [super viewDidAppear:animated];
}

- (void)toggleSideView {
   
}

@end
