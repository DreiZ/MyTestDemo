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
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@end

@implementation ZStudentMineLessonTimetableCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.lessonLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(18));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(8));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(8));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(16));
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
        _backView.backgroundColor = randomColor();
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _titleLabel.text = @"11:20~12:30";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontMin]];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _titleLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = [UIColor colorWhite];
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.text = @"三十多个开始";
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldFontSmall]];
        [_lessonLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _lessonLabel;
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth-CGFloatIn750(252))/4.0, (KScreenWidth-CGFloatIn750(252))/4 * (64.0/62.0));
}
@end


