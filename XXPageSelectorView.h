//
//  XXPageSelectorView.h
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedAtIndexBlock)(NSUInteger index);

@interface XXPageSelectorView : UIView

@property(nonatomic, assign) NSUInteger selectedIndex;
@property(nonatomic, strong) UIColor *separatorLineColor;
@property(nonatomic, strong) NSArray *sourceItems;
@property(nonatomic, copy) DidSelectedAtIndexBlock block_didSelectedAtIndex;

- (id)initWithFrame:(CGRect)frame itemTitles:(NSArray *)array;
@end

@interface XXPageSelectorItem : UIButton
@property(nonatomic, strong) UIColor *indicatorColor;
@end
