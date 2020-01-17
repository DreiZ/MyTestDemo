//
//  ZStudentStarListCollectionViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarListCollectionViewCell.h"

@interface ZStudentStarListCollectionViewCell ()
@property (nonatomic,strong) UIView *contBackView;

@end

@implementation ZStudentStarListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = KBackColor;
    self.clipsToBounds = YES;
    
    UIView *skillBackView = [[UIView alloc] initWithFrame:CGRectZero];
    skillBackView.backgroundColor = KMainColor;
    skillBackView.layer.cornerRadius = CGFloatIn750(20);
    
    
    [self.contentView addSubview:self.contBackView];
    [self.contBackView addSubview:self.userImageView];
    [self.contBackView addSubview:self.titleLabel];
    [self.contBackView addSubview:skillBackView];
    [self.contBackView addSubview:self.skillLabel];
    
    [self.contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
   
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(240));
        make.top.left.right.equalTo(self.contBackView).offset(CGFloatIn750(0));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userImageView.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    [self.skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.userImageView.mas_centerX);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(20));
        }];
    

    [skillBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.skillLabel);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.skillLabel.mas_left).offset(-CGFloatIn750(30));
        make.right.equalTo(self.skillLabel.mas_right).offset(CGFloatIn750(30));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_whenTapped:^{
        if (weakSelf.detailBlock) {
            weakSelf.detailBlock(weakSelf.userImageView);
        }
    }];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark -懒加载
- (UIView *)contBackView {
    if (!_contBackView) {
        _contBackView = [[UIView alloc] init];
        _contBackView.layer.masksToBounds = YES;
        _contBackView.backgroundColor = KWhiteColor;
        _contBackView.layer.cornerRadius = CGFloatIn750(10);
    }
    return _contBackView;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = CGFloatIn750(10);
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KFont2Color;
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _titleLabel;
}

- (UILabel *)skillLabel {
    if (!_skillLabel) {
        _skillLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _skillLabel.layer.masksToBounds = YES;
        _skillLabel.textColor = KWhiteColor;
        _skillLabel.numberOfLines = 1;
        _skillLabel.textAlignment = NSTextAlignmentCenter;
        [_skillLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _skillLabel;
}

- (void)setModel:(ZStudentDetailLessonOrderCoachModel *)model {
    _model = model;
    self.userImageView.image = [UIImage imageNamed:model.coachImage];
    self.titleLabel.text = model.coachName;
    
    if (model.adeptArr && model.adeptArr.count > 0) {
        _skillLabel.text = model.adeptArr[0];
    }
    
}
@end
