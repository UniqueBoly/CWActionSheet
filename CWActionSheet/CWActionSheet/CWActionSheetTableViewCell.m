//
//  CWActionSheetTableViewCell.m
//  CWActionSheet
//
//  Created by 吴波 on 2017/3/16.
//  Copyright © 2017年 wubo. All rights reserved.
//

#import "CWActionSheetTableViewCell.h"

#define K_ScrrenWidth [UIScreen mainScreen].bounds.size.width

@implementation CWActionSheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textLab];
    }
    [self setNeedsLayout];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLab.frame = CGRectMake(0, 0, K_ScrrenWidth, 50);
}

- (UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc] init];
        _textLab.font = [UIFont systemFontOfSize:16];
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.textColor = [UIColor blackColor];
        _textLab.backgroundColor = [UIColor whiteColor];
    }
    return _textLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
