//
//  ZStudentLessonSelectTimeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectTimeCell.h"

@interface ZStudentLessonSelectTimeCell ()
//@property (nonatomic,strong) UILabel *titleLabel;

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
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

- (void)setModel:(ZStudentDetailLessonTimeModel *)model {
    _model = model;
    [_titleLabel setFont:[UIFont fontContent]];
    _titleLabel.text = model.time;
    if (model.isTimeSelected) {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }else {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
}

- (void)setClassifyModel:(ZMainClassifyOneModel *)classifyModel {
    _classifyModel = classifyModel;

    _titleLabel.text = classifyModel.name;
    
    if (classifyModel.isSelected) {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }else {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
}


- (void)setTimeModel:(ZOriganizationLessonExperienceTimeModel *)timeModel {
    _timeModel = timeModel;
    NSString *week = [[[NSDate alloc] initWithTimeIntervalSince1970:[timeModel.date doubleValue]] formatWeekday];
    NSString *data = [timeModel.date timeStringWithFormatter:[NSString stringWithFormat:@"MM月dd日"]];
    _titleLabel.text = [NSString stringWithFormat:@"%@(%@)",data,week];
    
    if (timeModel.isTimeSelected) {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }else {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(106);
}
@end
