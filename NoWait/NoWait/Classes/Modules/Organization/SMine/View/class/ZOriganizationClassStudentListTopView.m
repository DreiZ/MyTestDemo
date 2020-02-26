//
//  ZOriganizationClassStudentListTopView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClassStudentListTopView.h"

@interface ZOriganizationClassStudentListTopView ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *handleLabel;

@end

@implementation ZOriganizationClassStudentListTopView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.numLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.handleLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
    }];
    
    [self.handleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"姓名";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _numLabel.text = @"上课进度";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontContent]];
    }
    return _numLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _detailLabel.text = @"签到详情";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}

- (UILabel *)handleLabel {
    if (!_handleLabel) {
        _handleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _handleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _handleLabel.text = @"操作";
        _handleLabel.numberOfLines = 1;
        _handleLabel.textAlignment = NSTextAlignmentCenter;
        [_handleLabel setFont:[UIFont fontContent]];
    }
    return _handleLabel;
}

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    if (isOpen) {
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0f);
        }];
        
        [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0f);
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0f);
        }];
    }else{
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
        }];
        
        [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
        }];
        
        [self.handleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.detailLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0f);
        }];
    }
}

@end
