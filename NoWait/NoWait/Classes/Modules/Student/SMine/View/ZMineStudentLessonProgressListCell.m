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
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(18));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    
    [self.contentView addSubview:self.lessonProgressBackView];
    [self.lessonProgressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonTitleLabel.mas_right).offset(CGFloatIn750(24));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(180));
        make.height.mas_equalTo(CGFloatIn750(20));
    }];
    
    [self.lessonProgressBackView addSubview:self.lessonProgressView];
    [self.lessonProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.lessonProgressBackView);
        make.width.equalTo(self.lessonProgressBackView).multipliedBy(0.3);
    }];
    
    [self.contentView addSubview:self.lessonCountLabel];
    [self.lessonCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonProgressBackView.mas_right).offset(CGFloatIn750(120));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
}


#pragma mark -Getter
- (UIView *)lessonProgressBackView {
    if (!_lessonProgressBackView) {
        _lessonProgressBackView = [[UIView alloc] init];
        _lessonProgressBackView.layer.masksToBounds = YES;
        _lessonProgressBackView.clipsToBounds = YES;
        _lessonProgressBackView.layer.borderColor = KMainColor.CGColor;
        _lessonProgressBackView.layer.borderWidth = 0.5;
        _lessonProgressBackView.backgroundColor = [UIColor whiteColor];
    }
    return _lessonProgressBackView;
}

- (UIView *)lessonProgressView {
    if (!_lessonProgressView) {
        _lessonProgressView = [[UIView alloc] init];
        _lessonProgressView.layer.masksToBounds = YES;
        _lessonProgressView.clipsToBounds = YES;
        _lessonProgressView.backgroundColor = KMainColor;
    }
    return _lessonProgressView;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = KFont6Color;
        _lessonTitleLabel.text = @"瑜伽";
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _lessonTitleLabel;
}

- (UILabel *)lessonCountLabel {
    if (!_lessonCountLabel) {
        _lessonCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonCountLabel.textColor = KAdaptAndDarkColor(KFont8Color, KFont3Color);
        _lessonCountLabel.text = @"20/30节";
        _lessonCountLabel.numberOfLines = 1;
        _lessonCountLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonCountLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _lessonCountLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(54);
}
@end
