//
//  ZTeacherMineSignListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineSignListCell.h"

@interface ZTeacherMineSignListCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *lessonNameLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *classNameLabel;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UIView *topLineView;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *openBtn;
@property (nonatomic,strong) UIButton *studentListBtn;
@property (nonatomic,strong) UIButton *signBtn;
@end

@implementation ZTeacherMineSignListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor =  adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(0));
    }];
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
    [topView addSubview:self.userImageView];
    [topView addSubview:self.nameLabel];
    [topView addSubview:self.userLabel];
    [topView addSubview:self.stateLabel];
    [topView addSubview:self.numLabel];
    [topView addSubview:self.classNameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(30));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [topView addSubview:self.lessonNameLabel];
    [self.lessonNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(88));
    }];

    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.lessonNameLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(10));
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userLabel.mas_left).offset(-CGFloatIn750(10));
        make.bottom.equalTo(topView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.userImageView.mas_left).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    
    [_bottomView addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(40));
        make.height.mas_equalTo(1);
    }];
    
    [self.bottomView addSubview:self.openBtn];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.bottomView);
        make.top.equalTo(self.topLineView.mas_bottom);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
    
    
    [self.bottomView addSubview:self.studentListBtn];
    [self.studentListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.bottomView);
        make.top.equalTo(self.topLineView.mas_bottom);
        make.right.equalTo(self.bottomView.mas_centerX);
    }];
    
    [self.bottomView addSubview:self.signBtn];
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.studentListBtn addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.studentListBtn.mas_right);
        make.top.equalTo(self.topLineView.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(30));
        make.width.mas_equalTo(1);
    }];
    
    UIView *sbottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    sbottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.signBtn addSubview:sbottomLineView];
    [sbottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signBtn.mas_right);
        make.top.equalTo(self.topLineView.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(30));
        make.width.mas_equalTo(1);
    }];
    
    self.signBtn.hidden = YES;
}


#pragma mark - Getter
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.layer.cornerRadius = CGFloatIn750(20);
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}


- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    }
    return _topLineView;
}



- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(20);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]));
    }
    return _contView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _stateLabel.numberOfLines = 1;
        _stateLabel.textAlignment = NSTextAlignmentRight;
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
        [_nameLabel setFont:[UIFont boldFontSmall]];
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
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
        
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}

- (UILabel *)classNameLabel {
    if (!_classNameLabel) {
        _classNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _classNameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _classNameLabel.numberOfLines = 1;
        _classNameLabel.textAlignment = NSTextAlignmentLeft;
        [_classNameLabel setFont:[UIFont fontContent]];
    }
    return _classNameLabel;
}

- (UILabel *)lessonNameLabel {
    if (!_lessonNameLabel) {
        _lessonNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _lessonNameLabel.numberOfLines = 1;
        _lessonNameLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonNameLabel setFont:[UIFont boldFontTitle]];
    }
    return _lessonNameLabel;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_openBtn setTitle:@"开始上课" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        [_openBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1,self.model);
            };
        }forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}


- (UIButton *)signBtn {
    if (!_signBtn) {
        __weak typeof(self) weakSelf = self;
        _signBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_signBtn setTitle:@"班级签到" forState:UIControlStateNormal];
        [_signBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        [_signBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,self.model);
            };
        }forControlEvents:UIControlEventTouchUpInside];
    }
    return _signBtn;
}


- (UIButton *)studentListBtn {
    if (!_studentListBtn) {
        __weak typeof(self) weakSelf = self;
        _studentListBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_studentListBtn setTitle:@"学员列表" forState:UIControlStateNormal];
        [_studentListBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_studentListBtn.titleLabel setFont:[UIFont fontContent]];
        [_studentListBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0,self.model);
            };
        }forControlEvents:UIControlEventTouchUpInside];
    }
    return _studentListBtn;
}

- (void)setModel:(ZOriganizationClassListModel *)model{
    _model = model;
    _lessonNameLabel.text = SafeStr(model.name);
    _classNameLabel.text = SafeStr(model.stores_courses_short_name);
    
    _userLabel.text = SafeStr(model.teacher_name);
    _nameLabel.text = SafeStr(model.stores_name);
    
    _numLabel.hidden = NO;
    _stateLabel.hidden = YES;
//    ：全部 1：待开班 2：已开班 3：已结班
    NSString *status = @"待开班";
    if ([model.status intValue] == 1) {
        status = @"待开班";
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }else if ([model.status intValue] == 2) {
        status = @"已开班";
        status = [NSString stringWithFormat:@"%@%@/%@",status,SafeStr(model.now_progress),SafeStr(model.total_progress)];
        _numLabel.hidden = NO;
        _stateLabel.hidden = YES;
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }else if ([model.status intValue] == 3) {
        status = @"已结班";
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    
    _numLabel.text = status;
    _stateLabel.text = @"";
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.teacher_image)] placeholderImage:[UIImage imageNamed:@"default_head"]] ;
    
    if ([model.can_sign intValue] == 1) {
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        _openBtn.enabled = YES;
    }else{
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
        _openBtn.enabled = NO;
    }
    
    CGSize tempSize = [model.teacher_name sizeForFont:[UIFont fontSmall] size:CGSizeMake(KScreenWidth/3.0, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    
    [self.userLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_equalTo(tempSize.width + 2);
    }];
    
    if (ValidStr(model.now_progress) && [model.now_progress intValue] > 0) {
        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.bottomView);
            make.top.equalTo(self.topLineView.mas_bottom);
            make.left.equalTo(self.bottomView.mas_right).multipliedBy(2.0/3);
        }];
        
        [self.studentListBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.bottomView);
            make.top.equalTo(self.topLineView.mas_bottom);
            make.right.equalTo(self.bottomView.mas_right).multipliedBy(1.0/3);
        }];
        
        [self.signBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.studentListBtn.mas_right);
            make.top.equalTo(self.topLineView.mas_bottom);
            make.bottom.equalTo(self.bottomView);
            make.right.equalTo(self.openBtn.mas_left);
        }];
        self.signBtn.hidden = NO;
    }else {
        [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.bottomView);
            make.top.equalTo(self.topLineView.mas_bottom);
            make.left.equalTo(self.bottomView.mas_centerX);
        }];
        
        [self.studentListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.bottomView);
            make.top.equalTo(self.topLineView.mas_bottom);
            make.right.equalTo(self.bottomView.mas_centerX);
        }];
        
        self.signBtn.hidden = YES;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(348);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    ViewBorderRadius(_openBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
}
@end

