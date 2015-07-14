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
 
    _infoLab  = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_infoLab];
    _infoLab.numberOfLines = 0;
    _infoLab.lineBreakMode=NSLineBreakByCharWrapping;
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40*TTScreenWith/640];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:40];
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    _infoLab.font = [UIFont systemFontOfSize:24*TTScreenWith/640];
    
    
     _addressLab = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_addressLab];
    [_addressLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30*TTScreenWith/640];
    [_addressLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_infoLab withOffset:15];
    [_addressLab autoSetDimension:ALDimensionWidth toSize:200];
    _addressLab.font=[UIFont fontWithName:nil size:12];

    
     _timeLab = [UILabel newAutoLayoutView];
    [self.contentView addSubview:_timeLab];
    [_timeLab autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_addressLab];
    [_timeLab autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:15];
    [_timeLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_addressLab withOffset:40];
     _timeLab.font=[UIFont fontWithName:nil size:12];
     _timeLab.textAlignment=NSTextAlignmentRight;

    
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    _infoLab.preferredMaxLayoutWidth = CGRectGetWidth(_infoLab.frame);
    _addressLab.preferredMaxLayoutWidth = CGRectGetWidth(_addressLab.frame);
    
}

@end
