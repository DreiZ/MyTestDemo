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
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *openBtn;
@end

@implementation ZOrganizationClassManageListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

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
    
    [topView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
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
        make.width.mas_equalTo(CGFloatIn750(192));
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
    }
    return _contView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _stateLabel.text = @"待开课";
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
        _nameLabel.text = @"学习力小香猪";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
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
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _numLabel.text = @"112人";
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
        _buLabel.text = @"补课";
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
        _detailLabel.text = @"学了就是哈哈哈";
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
        [_deleteBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _deleteBtn;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn setTitle:@"立即开课" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_openBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
        [_openBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        }];
    }
    return _openBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(348);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_deleteBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}
@end




