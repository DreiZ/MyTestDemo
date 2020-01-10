//
//  ZStudentLessonSelectTimeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectTimeCell.h"

@interface ZStudentLessonSelectTimeCell ()
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZStudentLessonSelectTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = KWhiteColor;
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(54));
        make.width.mas_equalTo(CGFloatIn750(235));
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KFont2Color;
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _titleLabel;
}

- (void)setModel:(ZStudentDetailLessonTimeModel *)model {
    _model = model;
    
    _titleLabel.text = model.time;
    if (model.isTimeSelected) {
        _titleLabel.textColor = KWhiteColor;
        _titleLabel.backgroundColor = KMainColor;
        _titleLabel.layer.cornerRadius = CGFloatIn750(27);
        _titleLabel.layer.masksToBounds = YES;
    }else {
        _titleLabel.textColor = KFont2Color;
        _titleLabel.backgroundColor = KWhiteColor;
        _titleLabel.layer.cornerRadius = CGFloatIn750(27);
        _titleLabel.layer.masksToBounds = YES;
    }
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(68);
}
@end
