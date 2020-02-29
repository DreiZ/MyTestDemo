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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
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
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userLabel.mas_left).offset(-CGFloatIn750(10));
        make.bottom.equalTo(topView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
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

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(20);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, [UIColor colorGrayBG]);
    }
    return _contView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _stateLabel.text = @"待开课";
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
        _nameLabel.text = @"才玩俱乐部";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontSmall]];
    }
    return _nameLabel;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"serverTopbg"];
        ViewRadius(_userImageView, CGFloatIn750(22));
    }
    return _userImageView;
}


- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _userLabel.text = @"香香老师";
        _userLabel.numberOfLines = 1;
        _userLabel.textAlignment = NSTextAlignmentRight;
        [_userLabel setFont:[UIFont fontSmall]];
    }
    return _userLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _numLabel.text = @"已开课5/10";
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
        _classNameLabel.text = @"初级班级";
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
        _lessonNameLabel.text = @"克城市的高斯公安问过他问过特";
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
        [_signBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_signBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
        [_signBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _signBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(348);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_signBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}
@end







