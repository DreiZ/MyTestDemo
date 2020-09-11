//
//  ZMineStudentLessonProgressListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentLessonProgressListCell.h"

@interface ZMineStudentLessonProgressListCell ()
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *lessonProgressBackView;
@property (nonatomic,strong) UIView *lessonProgressView;
@property (nonatomic,strong) UILabel *lessonCountLabel;

@end


@implementation ZMineStudentLessonProgressListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.lessonProgressBackView];
    [self.lessonProgressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(86));
    }];
    
    [self.lessonProgressBackView addSubview:self.lessonProgressView];
    [self.lessonProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.lessonProgressBackView);
        make.width.equalTo(self.lessonProgressBackView).multipliedBy(0.3);
    }];
    
    [self.contentView addSubview:self.lessonCountLabel];
    [self.contentView addSubview:self.lessonTitleLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonProgressBackView.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-CGFloatIn750(2));
        make.right.equalTo(self.lessonCountLabel.mas_left).offset(-CGFloatIn750(20));
    }];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonProgressBackView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(2));
        make.right.equalTo(self.lessonCountLabel.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.lessonCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lessonProgressBackView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
}


#pragma mark -Getter
- (UIView *)lessonProgressBackView {
    if (!_lessonProgressBackView) {
        _lessonProgressBackView = [[UIView alloc] init];
        _lessonProgressBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_lessonProgressBackView, CGFloatIn750(43));
    }
    return _lessonProgressBackView;
}

- (UIView *)lessonProgressView {
    if (!_lessonProgressView) {
        _lessonProgressView = [[UIView alloc] init];
        ViewRadius(_lessonProgressView, CGFloatIn750(43));
        _lessonProgressView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _lessonProgressView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontSmall]];
    }
    return _nameLabel;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont fontSmall]];
    }
    return _lessonTitleLabel;
}

- (UILabel *)lessonCountLabel {
    if (!_lessonCountLabel) {
        _lessonCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonCountLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _lessonCountLabel.numberOfLines = 1;
        _lessonCountLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonCountLabel setFont:[UIFont fontSmall]];
    }
    return _lessonCountLabel;
}

- (void)setModel:(ZOriganizationClassListModel *)model {
    _model = model;
    if (!ValidStr(model.total_progress)) {
        model.total_progress = model.now_progress;
        _model.total_progress = _model.now_progress;
    }
    _lessonCountLabel.text = [NSString stringWithFormat:@"%@%@%@节",[NSString stringWithFormat:@"%d",[SafeStr(model.now_progress) intValue] + [SafeStr(model.replenish_nums) intValue]],@"/",SafeStr(model.total_progress)];
    _lessonTitleLabel.text = [NSString stringWithFormat:@"%@",model.stores_courses_short_name];
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.student_name];
    
    _lessonProgressView.backgroundColor = randomColorWithNum([model.course_id intValue]);
    
    CGSize countSize = [SafeStr(_lessonCountLabel.text) tt_sizeWithFont:[UIFont fontSmall]];
    
    CGSize leftSize = [SafeStr(_lessonTitleLabel.text) tt_sizeWithFont:[UIFont fontSmall]];
    CGFloat labelMin = (leftSize.width + CGFloatIn750(30) + 4)/(KScreenWidth - CGFloatIn750(60));
    CGFloat labelMax = (KScreenWidth - CGFloatIn750(90))/(KScreenWidth - CGFloatIn750(60));
    CGFloat muti = 0;
    if (ValidStr(model.total_progress) && [SafeStr(model.total_progress) floatValue] >= [model.now_progress floatValue] && [SafeStr(model.total_progress) intValue] > 0) {
        muti = [model.now_progress floatValue] / [SafeStr(model.total_progress) floatValue];
    }
    
    [self.lessonCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lessonProgressBackView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(countSize.width+2);
    }];
    
    CGFloat min = CGFloatIn750(86)/(KScreenWidth - CGFloatIn750(60));
    if (muti > 0 && muti <= min) {
        muti = min;
    }
    
    if (muti > 1) {
        muti = 1;
    }
    
    if (muti > labelMin) {
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
    }else{
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    
    if (muti > labelMax) {
        _lessonCountLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
    }else{
        _lessonCountLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }

    [self.lessonProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.lessonProgressBackView);
        make.width.equalTo(self.lessonProgressBackView.mas_width).multipliedBy(muti);
    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(106);
}
@end
