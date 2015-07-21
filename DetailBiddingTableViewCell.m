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
    
    _titleLab = [UILabel new];
 
    
    [self.contentView addSubview:_titleLab];
   
    
    _infoLab  = [UILabel new];
  
    [self.contentView addSubview:_infoLab];
    
    
    _titleLab.font = [UIFont systemFontOfSize:28*TTScreenWith/640];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.right.equalTo(self.infoLab.mas_left).with.offset(-15);
      

    }];
    
   

    _infoLab.numberOfLines = 0;
    _infoLab.lineBreakMode = NSLineBreakByCharWrapping;
    _infoLab.font          = [UIFont systemFontOfSize:24*TTScreenWith/640];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.titleLab.mas_right).with.offset(15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
           }];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
   _infoLab.preferredMaxLayoutWidth = CGRectGetWidth(_infoLab.frame);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
