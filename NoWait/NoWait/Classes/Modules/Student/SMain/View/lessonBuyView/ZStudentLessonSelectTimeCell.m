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
    [super setupView];

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
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

- (void)setModel:(ZStudentDetailLessonTimeModel *)model {
    _model = model;
    
    _titleLabel.text = model.time;
    if (model.isTimeSelected) {
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _titleLabel.backgroundColor = [UIColor  colorMain];
        _titleLabel.layer.cornerRadius = CGFloatIn750(27);
        _titleLabel.layer.masksToBounds = YES;
    }else {
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _titleLabel.layer.cornerRadius = CGFloatIn750(27);
        _titleLabel.layer.masksToBounds = YES;
    }
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(68);
}
@end
