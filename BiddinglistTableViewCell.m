//
//  BiddinglistTableViewCell.m
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "BiddinglistTableViewCell.h"

@implementation BiddinglistTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
    
}
-(void)createUI{
    _titleLab = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_titleLab];
    [_titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30*TTScreenWith/640];
    _titleLab.font = [UIFont systemFontOfSize:28*TTScreenWith/640];
    
    _infoLab  = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_infoLab];
    [_infoLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20*TTScreenWith/640];
    [_infoLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLab withOffset:10];
    _infoLab.font = [UIFont systemFontOfSize:24*TTScreenWith/640];
    _infoLab.textAlignment = NSTextAlignmentLeft;
    
    
    
}

@end
