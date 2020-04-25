//
//  ZStudentMineLessonTimetableCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineLessonTimetableCollectionCell.h"

@interface ZStudentMineLessonTimetableCollectionCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@end

@implementation ZStudentMineLessonTimetableCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.lessonLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(18));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(10));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(8));
        make.top.equalTo(self.timeLabel.mas_bottom).offset(CGFloatIn750(16));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(8));
        make.bottom.lessThanOrEqualTo(self.backView.mas_bottom);
    }];
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(12);
        
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
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentCenter;
        [_lessonLabel setFont:[UIFont boldFontSmall]];
        [_lessonLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _lessonLabel;
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    _lessonLabel.text = model.course_name;
    _timeLabel.text = model.time;
    NSArray *tempList = [model.time componentsSeparatedByString:@"~"];
    if (tempList && tempList.count > 0) {
        _timeLabel.text = tempList[0];
    }
    _backView.backgroundColor = randomColorWithNum([model.course_id intValue]+[model.courses_class_id intValue]);
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth-CGFloatIn750(252))/4.0, (KScreenWidth-CGFloatIn750(252))/4 * (64.0/62.0));
}
@end


