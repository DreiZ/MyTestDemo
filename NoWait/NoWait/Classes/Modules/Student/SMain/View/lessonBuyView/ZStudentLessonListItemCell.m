//
//  ZStudentLessonListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonListItemCell.h"

@interface ZStudentLessonListItemCell ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *selectImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end

@implementation ZStudentLessonListItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = KWhiteColor;
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(175));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contView addSubview:self.titleLabel];
    [self.contView addSubview:self.lessonLabel];
    [self.contView addSubview:self.timeLabel];
    [self.contView addSubview:self.numLabel];
    [self.contView addSubview:self.priceLabel];
    [self.contView addSubview:self.selectImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.contView).offset(CGFloatIn750(20));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(10));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.lessonLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(10));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(0));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(20));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(10));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(0));
        make.top.equalTo(self.lessonLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(10));
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.contView.mas_bottom);
    }];
    
}


#pragma mark -lazying loading---
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.borderWidth = 1;
        _contView.layer.borderColor = KBlackColor.CGColor;
        _contView.layer.cornerRadius = CGFloatIn750(20);
    }
    return _contView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KBlackColor;
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _titleLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = KFont6Color;
        _lessonLabel.text = @"";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _lessonLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = KFont6Color;
        _timeLabel.text = @"";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _timeLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = KFont6Color;
        _numLabel.text = @"";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [_numLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _numLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = KFont6Color;
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _priceLabel;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.image = [UIImage imageNamed:@"studentCoachSelect"];
        _selectImageView.layer.masksToBounds = YES;
    }
    return _selectImageView;
}

#pragma mark -setdata
-(void)setModel:(ZStudentDetailLessonListModel *)model {
    _model = model;
    _titleLabel.text = model.lessonTitle;
    _lessonLabel.text = model.lessonNum;
    _timeLabel.text = model.lessonTime;
    _numLabel.text = model.lessonStudentNum;
    _priceLabel.text = model.lessonPrice;
    
    if (model.isLessonSelected) {
        _titleLabel.textColor = KMainColor;
        _lessonLabel.textColor = KMainColor;
        _timeLabel.textColor = KMainColor;
        _numLabel.textColor = KMainColor;
        _priceLabel.textColor = KMainColor;
        _contView.layer.borderColor = KMainColor.CGColor;
        _selectImageView.hidden = NO;
    }else{
        _titleLabel.textColor = KBlackColor;
        _lessonLabel.textColor = KFont6Color;
        _timeLabel.textColor = KFont6Color;
        _numLabel.textColor = KFont6Color;
        _priceLabel.textColor = KFont6Color;
        _contView.layer.borderColor = KBlackColor.CGColor;
        _selectImageView.hidden = YES;
    }
}
@end
