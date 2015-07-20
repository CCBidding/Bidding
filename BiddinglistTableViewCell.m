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
 
    _infoLab    = [UILabel new];
    [self.contentView addSubview:_infoLab];

    _addressLab = [UILabel new];
    [self.contentView addSubview:_addressLab];

    _timeLab    = [UILabel new];
    [self.contentView addSubview:_timeLab];
    
    _infoLab.numberOfLines = 0;
    _infoLab.lineBreakMode=NSLineBreakByCharWrapping;
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.bottom.equalTo(_addressLab.mas_top).with.offset(-20);
        
    }];
    _infoLab.font = [UIFont systemFontOfSize:24*TTScreenWith/640];

    _addressLab.font=[UIFont fontWithName:nil size:10];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoLab.mas_bottom).with.offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(_timeLab.mas_left).with.offset(-20);
        make.width.equalTo(@200);
    }];

     _timeLab.font = [UIFont fontWithName:nil size:12];
     _timeLab.textAlignment = NSTextAlignmentRight;
    _timeLab.numberOfLines = 0;
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addressLab.mas_centerY);
        make.left.equalTo(_addressLab.mas_right).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
       
    }];

    
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    _infoLab.preferredMaxLayoutWidth = CGRectGetWidth(_infoLab.frame);
    _addressLab.preferredMaxLayoutWidth = CGRectGetWidth(_addressLab.frame);
    
}

@end
