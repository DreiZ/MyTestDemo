//
//  ZOrganizationClassManageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageListCell.h"

@interface ZOrganizationClassManageListCell ()

@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UILabel *buLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *openBtn;
@end

@implementation ZOrganizationClassManageListCell


-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    _topView = topView;
    
    [topView addSubview:self.userImageView];
    [topView addSubview:self.nameLabel];
    [topView addSubview:self.userLabel];
    [topView addSubview:self.stateLabel];
    [topView addSubview:self.numLabel];
    [topView addSubview:self.buLabel];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(30));
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stateLabel.mas_left);
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(88));
        make.right.equalTo(self.numLabel.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(44));
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userLabel.mas_left).offset(-CGFloatIn750(10));
        make.bottom.equalTo(topView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    [topView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.userImageView.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(50));
    }];
    
    [self.buLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.stateLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(52));
        make.height.mas_equalTo(CGFloatIn750(24));
    }];
    
    [self.bottomView addSubview:self.deleteBtn];
    [self.bottomView addSubview:self.openBtn];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(116));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(116));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    
}


#pragma mark - Getter
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _bottomView;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(12));
        _contView.clipsToBounds = YES;
    }
    return _contView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _stateLabel.numberOfLines = 1;
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        [_stateLabel setFont:[UIFont fontSmall]];
    }
    return _stateLabel;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        ViewRadius(_userImageView, CGFloatIn750(22));
    }
    return _userImageView;
}


- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _userLabel.numberOfLines = 1;
        _userLabel.textAlignment = NSTextAlignmentRight;
        [_userLabel setFont:[UIFont fontSmall]];
    }
    return _userLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}

- (UILabel *)buLabel {
    if (!_buLabel) {
        _buLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _buLabel.textColor = adaptAndDarkColor([UIColor colorOrangeMoment],[UIColor colorOrangeMoment]);
        
        _buLabel.numberOfLines = 1;
        _buLabel.textAlignment = NSTextAlignmentCenter;
        [_buLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
        ViewBorderRadius(_buLabel, CGFloatIn750(8), 1, [UIColor colorOrangeMoment]);
        _buLabel.backgroundColor = [UIColor colorOrangeBack];
    }
    return _buLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}



- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        __weak typeof(self) weakSelf = self;
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_deleteBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_deleteBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_openBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_openBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

- (void)setModel:(ZOriganizationClassListModel *)model {
    _model = model;
    
    _detailLabel.text = model.courses_name;
    _buLabel.text = @"补课";
    _numLabel.text = [NSString stringWithFormat:@"%@人",model.nums];
    _userLabel.text = model.teacher_name;
    _nameLabel.text = model.name;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.teacher_image)]];
    
    CGSize numSize = [self.numLabel.text sizeForFont:[UIFont fontSmall] size:CGSizeMake(KScreenWidth/2.0f, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    CGSize teacherNameSize = [self.userLabel.text sizeForFont:[UIFont fontContent] size:CGSizeMake(KScreenWidth/2.0f, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    
    [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_equalTo(numSize.width + 2);
    }];
    
    [self.userLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_equalTo(teacherNameSize.width + 2);
    }];

    _buLabel.hidden = [model.type intValue] == 1 ? YES : YES;
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    _openBtn.hidden = YES;
    _deleteBtn.hidden = YES;
    switch ([model.status intValue]) {
        case 1:
        {
            _stateLabel.text = [NSString stringWithFormat:@"%@(%@/%@)",@"待开班" ,SafeStr(model.now_progress),SafeStr(model.total_progress)];
            _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
            _openBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(self.contView);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView);
                make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
                make.width.mas_equalTo(CGFloatIn750(116));
                make.height.mas_equalTo(CGFloatIn750(56));
            }];
        }
            break;
        case 2:
        {
            _stateLabel.text = [NSString stringWithFormat:@"%@(%@/%@)",@"已开班" ,SafeStr(model.now_progress),SafeStr(model.total_progress)];
            _stateLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
            if ([_model.nums intValue] == 0) {
                _deleteBtn.hidden = NO;
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.bottom.right.equalTo(self.contView);
                  make.height.mas_equalTo(CGFloatIn750(136));
                }];
                [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.top.right.equalTo(self.contView);
                  make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.bottomView);
                    make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(20));
                    make.width.mas_equalTo(CGFloatIn750(116));
                    make.height.mas_equalTo(CGFloatIn750(56));
                }];
            }
        }
            break;
        case 3:
        {
            _stateLabel.text = [NSString stringWithFormat:@"%@(%@/%@)",@"已结班" ,SafeStr(model.now_progress),SafeStr(model.total_progress)];
            _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            if ([_model.nums intValue] == 0) {
                _deleteBtn.hidden = NO;
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.bottom.right.equalTo(self.contView);
                  make.height.mas_equalTo(CGFloatIn750(136));
                }];
                [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.top.right.equalTo(self.contView);
                  make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.bottomView);
                    make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(20));
                    make.width.mas_equalTo(CGFloatIn750(116));
                    make.height.mas_equalTo(CGFloatIn750(56));
                }];
            }
        }
            break;

        default:
        {
            _stateLabel.text = @"";
            if ([_model.nums intValue] == 0) {
                _deleteBtn.hidden = NO;
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.bottom.right.equalTo(self.contView);
                  make.height.mas_equalTo(CGFloatIn750(136));
                }];
                [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.top.right.equalTo(self.contView);
                  make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.bottomView);
                    make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(20));
                    make.width.mas_equalTo(CGFloatIn750(116));
                    make.height.mas_equalTo(CGFloatIn750(56));
                }];
            }
        }
            break;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    if (ValidClass(sender, [ZOriganizationClassListModel class])) {
        ZOriganizationClassListModel *model = sender;
        if ([model.status intValue] == 1 || [model.nums intValue] == 0) {
            return CGFloatIn750(348);
        }
    }
    return CGFloatIn750(348 - 96);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_deleteBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}
@end




