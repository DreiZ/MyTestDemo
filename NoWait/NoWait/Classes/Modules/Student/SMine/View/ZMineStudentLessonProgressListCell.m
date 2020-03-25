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
    
    [self.contentView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonProgressBackView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.lessonCountLabel];
    [self.lessonCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lessonProgressBackView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
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

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _lessonTitleLabel.text = @"瑜伽";
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont fontContent]];
    }
    return _lessonTitleLabel;
}

- (UILabel *)lessonCountLabel {
    if (!_lessonCountLabel) {
        _lessonCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonCountLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonCountLabel.text = @"20/30节";
        _lessonCountLabel.numberOfLines = 1;
        _lessonCountLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonCountLabel setFont:[UIFont fontSmall]];
    }
    return _lessonCountLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(106);
}
@end
