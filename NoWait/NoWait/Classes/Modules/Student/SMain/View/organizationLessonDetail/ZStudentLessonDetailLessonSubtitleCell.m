//
//  ZStudentLessonDetailLessonSubtitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailLessonSubtitleCell.h"


@interface ZStudentLessonDetailLessonSubtitleCell ()
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZStudentLessonDetailLessonSubtitleCell

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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorTextGray];
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(68);
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _titleLabel.text = detail;
}
@end
