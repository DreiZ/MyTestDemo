//
//  ZOrganizationLessonTypeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonTypeCell.h"

@interface ZOrganizationLessonTypeCell ()

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *hintImageView;

@end

@implementation ZOrganizationLessonTypeCell

-(void)setupView {
    [super setupView];
    
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.hintImageView];
    
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(140));
    }];
    
   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(10));
       make.centerY.equalTo(self.mas_centerY);
       make.width.height.mas_equalTo(CGFloatIn750(36));
   }];
   
   
   [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.rightTitleLabel.mas_right).offset(CGFloatIn750(10));
       make.centerY.equalTo(self.mas_centerY);
       make.width.height.mas_equalTo(CGFloatIn750(36));
   }];
    
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(36));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.isEdit) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
            weakSelf.isGu = @"1";
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.leftTitleLabel.mas_left);
        make.right.equalTo(self.leftImageView.mas_right);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.isEdit) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
            weakSelf.isGu = @"2";
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.rightTitleLabel.mas_left);
        make.right.equalTo(self.rightImageView.mas_right);
    }];
    
    UIButton *hintBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [hintBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(2);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:hintBtn];
    [hintBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.hintImageView.mas_left).offset(-CGFloatIn750(26));
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    _hintImageView.hidden = YES;
}


#pragma mark -Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"固定时间开课";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont fontContent]];
    }
    return _leftTitleLabel;
}


- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _rightTitleLabel.text = @"人满开课";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_rightTitleLabel setFont:[UIFont fontContent]];
    }
    return _rightTitleLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"selectedCycle"];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
    return _rightImageView;
}

- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
        _hintImageView.image = [[UIImage imageNamed:@"questionHint"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _hintImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    return _hintImageView;
}

- (void)setIsGu:(NSString *)isGu {
    _isGu = isGu;
    if ([isGu intValue] == 1) {
        _leftImageView.image = [UIImage imageNamed:@"selectedCycle"];
        _rightImageView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }else{
        _leftImageView.image = [UIImage imageNamed:@"unSelectedCycle"];
        _rightImageView.image = [UIImage imageNamed:@"selectedCycle"];
    }
}

- (void)setLeftTitle:(NSString *)left rightTitle:(NSString *)right {
    _rightTitleLabel.text = right;
    _leftTitleLabel.text = left;
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(86);
}
@end


