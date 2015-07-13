//
//  PPRegistTableViewCell.m
//  招标
//
//  Created by ppan on 15/7/13.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "PPRegistTableViewCell.h"
#define kCellIdentifier @"cellIdentifier"
@implementation PPRegistTableViewCell{

}

- (void)awakeFromNib {
    // Initialization code
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField = [UITextField newAutoLayoutView];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:self.textField];
        [self.textField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 130, 10, 30)];
     
    }


    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
