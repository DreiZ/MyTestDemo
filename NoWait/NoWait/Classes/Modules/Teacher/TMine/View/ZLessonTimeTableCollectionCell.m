//
//  ZLessonTimeTableCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLessonTimeTableCollectionCell.h"

@interface ZLessonTimeTableCollectionCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation ZLessonTimeTableCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.lessonLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(2));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(4));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(2));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(2));
        make.top.equalTo(self.timeLabel.mas_bottom).offset(CGFloatIn750(2));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(2));
        make.bottom.lessThanOrEqualTo(self.backView.mas_bottom);
    }];
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(12);
        _backView.backgroundColor = randomColor();
    }
    return _backView;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_timeLabel setFont:[UIFont boldFontSmall]];
        [_timeLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _timeLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = [UIColor colorWhite];
        _lessonLabel.numberOfLines = 0;
        _lessonLabel.textAlignment = NSTextAlignmentCenter;
        [_lessonLabel setFont:[UIFont boldFontSmall]];
        [_lessonLabel setAdjustsFontForContentSizeCategory:YES];
    }
    return _lessonLabel;
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    if (model) {
        if (ValidStr(model.course_name)) {
            _lessonLabel.text = model.course_name;
            NSArray *tempList = [model.time componentsSeparatedByString:@"~"];
            if (tempList && tempList.count > 0) {
                _timeLabel.text = tempList[0];
            }
//            _timeLabel.text = model.time;
            _backView.backgroundColor = randomColor();
        }else{
            _backView.backgroundColor = [UIColor clearColor];
        }
    }else{
        _lessonLabel.text = @"";
        _timeLabel.text = @"";
        _backView.backgroundColor = [UIColor clearColor];
    }
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth - CGFloatIn750(48) - CGFloatIn750(20))/7.0f, (KScreenWidth - CGFloatIn750(76) - CGFloatIn750(30) - CGFloatIn750(28))/7.0f +CGFloatIn750(20));
}
@end


