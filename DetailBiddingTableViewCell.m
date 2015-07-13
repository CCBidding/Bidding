//
//  DetailBiddingTableViewCell.m
//  招标
//
//  Created by mac chen on 15/7/7.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "DetailBiddingTableViewCell.h"

@implementation DetailBiddingTableViewCell

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
    [_infoLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    [_infoLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLab withOffset:10];
    _infoLab.font          = [UIFont systemFontOfSize:24*TTScreenWith/640];
    _infoLab.textAlignment = NSTextAlignmentRight;
    
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    // _infoLab.preferredMaxLayoutWidth  = CGRectGetWidth(_infoLab.frame);
    //_titleLab.preferredMaxLayoutWidth = CGRectGetWidth(_titleLab.frame);
    _infoLab.preferredMaxLayoutWidth = CGRectGetWidth(_infoLab.frame);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
