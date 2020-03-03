//
//  ZStudentLessonOrderIntroItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderIntroItemCell.h"

@interface ZStudentLessonOrderIntroItemCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subLabel;

@end

@implementation ZStudentLessonOrderIntroItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(40));
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(CGFloatIn750(18));
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontTitle]];
    }
    return _titleLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _subLabel.text = @"";
        _subLabel.numberOfLines = 1;
        _subLabel.textAlignment = NSTextAlignmentLeft;
        [_subLabel setFont:[UIFont fontTitle]];
    }
    return _subLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(56);
}

- (void)setModel:(ZStudentLessonOrderInfoCellModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _subLabel.text = model.subTitle;
    _subLabel.textColor = model.subColor;
}
@end
