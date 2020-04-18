//
//  ZStudentMineSignListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignListCell.h"

@interface ZStudentMineSignListCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *lessonNameLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *classNameLabel;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *signBtn;
@end

@implementation ZStudentMineSignListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
    [self.topView addSubview:self.userImageView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.userLabel];
    [self.topView addSubview:self.stateLabel];
    [self.topView addSubview:self.numLabel];
    [self.topView addSubview:self.classNameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.topView.mas_top).offset(CGFloatIn750(30));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [self.topView addSubview:self.lessonNameLabel];
    [self.lessonNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.topView.mas_top).offset(CGFloatIn750(88));
    }];

    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.lessonNameLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userLabel.mas_left).offset(-CGFloatIn750(10));
        make.bottom.equalTo(self.topView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    [self.bottomView addSubview:self.signBtn];
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(116));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    
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

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _topView;
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


- (UIButton *)signBtn {
    if (!_signBtn) {
        __weak typeof(self) weakSelf = self;
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_signBtn setTitle:@"去签课" forState:UIControlStateNormal];
        [_signBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_signBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_signBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model);
            };
        }];
    }
    return _signBtn;
}

- (void)setModel:(ZOriganizationClassListModel *)model{
    _model = model;
    _lessonNameLabel.text = model.stores_courses_name;
    _classNameLabel.text = model.courses_class_name;
    
    _userLabel.text = model.teacher_name;
    _nameLabel.text = model.stores_name;
    
    _numLabel.hidden = NO;
    _stateLabel.hidden = YES;
//    ：全部 1：待开课 2：已开课 3：已结课
    NSString *status = @"待排课";
    if ([model.status intValue] == 1) {
        status = @"待开课";
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }else if ([model.status intValue] == 2) {
        status = @"已开课";
        status = [NSString stringWithFormat:@"%@%@/%@",status,SafeStr(model.now_progress),SafeStr(model.total_progress)];
        _numLabel.hidden = NO;
        _stateLabel.hidden = YES;
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }else if ([model.status intValue] == 3) {
        status = @"已结课";
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    
    _numLabel.text = status;
    _stateLabel.text = @"";
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.teacher_image)] placeholderImage:[UIImage imageNamed:@"default_head"]] ;
    
    if ([model.can_operation intValue] != 1 || [model.status intValue] == 3) {
        _bottomView.hidden = YES;
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contView);
            make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(34));
        }];
    }else {
        _bottomView.hidden = NO;
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contView);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZOriganizationClassListModel *model = sender;
    if ([model.can_operation intValue] != 1 || [model.status intValue] == 3) {
        return CGFloatIn750(246);
    }
    return CGFloatIn750(348);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_signBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
}
@end
