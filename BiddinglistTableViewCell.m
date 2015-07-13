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
    _titleLab.numberOfLines = 0;
    [_titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30*TTScreenWith/640];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    _titleLab.font = [UIFont systemFontOfSize:28*TTScreenWith/640];
    
     _infoLab  = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_infoLab];
     _infoLab.numberOfLines = 0;
     _infoLab.lineBreakMode = NSLineBreakByCharWrapping;
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20*TTScreenWith/640];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:80];
    [_infoLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLab withOffset:10];
     _infoLab.font          = [UIFont systemFontOfSize:24*TTScreenWith/640];
     _infoLab.textAlignment = NSTextAlignmentRight;
    
    
     _addressLab = [UILabel newAutoLayoutView];
    _addressLab.numberOfLines=0;
    _addressLab.lineBreakMode=NSLineBreakByCharWrapping;
    [self.contentView addSubview:_addressLab];
    [_addressLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30*TTScreenWith/640];
    [_addressLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_addressLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_infoLab withOffset:60];
    _addressLab.font=[UIFont fontWithName:nil size:12];
    [_addressLab autoSetDimension:ALDimensionWidth toSize:200];
//     _addressLab.font = [UIFont systemFontOfSize:28*TTScreenWith/640];
    
     _timeLab = [UILabel newAutoLayoutView];
 
    [self.contentView addSubview:_timeLab];
    [_timeLab autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:15];
    [_timeLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_timeLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_addressLab withOffset:40];
     _timeLab.font=[UIFont fontWithName:nil size:12];

    
    
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
   // _infoLab.preferredMaxLayoutWidth  = CGRectGetWidth(_infoLab.frame);
    //_titleLab.preferredMaxLayoutWidth = CGRectGetWidth(_titleLab.frame);
    _addressLab.preferredMaxLayoutWidth = CGRectGetWidth(_addressLab.frame);
    
}

@end
