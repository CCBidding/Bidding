//
//  CDRTranslucentSideBar.h
//  CDRTranslucentSideBar
//
//  Created by UetaMasamichi on 2014/06/16.
//  Copyright (c) 2014年 nscallop. All rights reserved.
//

// 版权属于原作者
// http://code4app.com(cn) http://code4app.net(en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@class CDRTranslucentSideBar;
@protocol CDRTranslucentSideBarDelegate <NSObject>
@optional
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated;
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated;
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated;
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated;
@end

@interface CDRTranslucentSideBar : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat sideBarWidth;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic) BOOL translucent;
@property (nonatomic) UIBarStyle translucentStyle;
@property (nonatomic) CGFloat translucentAlpha;
@property (nonatomic, strong) UIColor *translucentTintColor;
@property (readonly) BOOL hasShown;
@property (readonly) BOOL showFromRight;
@property BOOL isCurrentPanGestureTarget;
@property NSInteger tag;

@property (nonatomic, weak) id<CDRTranslucentSideBarDelegate> delegate;

- (id)init;
- (id)initWithDirection:(BOOL)showFromRight;

- (void)show;
- (void)showAnimated:(BOOL)animated;
- (void)showInViewController:(UIViewController *)controller animated:(BOOL)animated;

- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

- (void)handlePanGestureToShow:(UIPanGestureRecognizer *)recognizer inView:(UIView *)parentView;

- (void)setContentViewInSideBar:(UIView *)contentView;

@end
