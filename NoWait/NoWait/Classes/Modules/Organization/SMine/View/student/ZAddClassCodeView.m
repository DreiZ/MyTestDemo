//
//  ZAddClassCodeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAddClassCodeView.h"

@interface ZAddClassCodeView ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *classLabel;
@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UILabel *classHintLabel;


@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation ZAddClassCodeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = CGFloatIn750(20);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    [self.topView addSubview:self.userImageView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.detailLabel];
    [self.topView addSubview:self.classLabel];
    [self.topView addSubview:self.codeImageView];
    [self.topView addSubview:self.classHintLabel];
    [self.bottomView addSubview:self.hintLabel];
    [self.bottomView addSubview:self.leftBtn];
    [self.bottomView addSubview:self.rightBtn];
    self.rightBtn.hidden = YES;
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(666));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(166));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(CGFloatIn750(40));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(60));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(400));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(-20));
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(22));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(600));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.classLabel.mas_bottom).offset(CGFloatIn750(18));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(600));
    }];
    
    
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(342));
    }];
    
    [self.classHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.codeImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(0));
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(CGFloatIn750(96));
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
    bottomLineView.hidden = YES;
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_right).multipliedBy(0.25);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(bottomLineView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(220));
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_right).multipliedBy(0.75);
        make.centerY.equalTo(bottomLineView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(220));
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    UIView *longView = [[UIView alloc] init];
    
    [self.topView addSubview:longView];
    [longView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.codeImageView);
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 0.5; //定义按的时间
    [longView addGestureRecognizer:longPress];
    
}

- (void)btnLong:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.handleBlock) {
            self.handleBlock(2);
        }
    }
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _classLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGray]);
        _classLabel.text = @"";
        _classLabel.numberOfLines = 1;
        _classLabel.textAlignment = NSTextAlignmentCenter;
        [_classLabel setFont:[UIFont fontContent]];
    }
    return _classLabel;
}



- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"课程：";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _hintLabel.text = @"长按二维码保存到相册";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        [_hintLabel setFont:[UIFont fontSmall]];
    }
    return _hintLabel;
}


- (UILabel *)classHintLabel {
    if (!_classHintLabel) {
        _classHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _classHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _classHintLabel.text = @"此二维码仅供添加线下学员使用";
        _classHintLabel.numberOfLines = 1;
        _classHintLabel.textAlignment = NSTextAlignmentCenter;
        [_classHintLabel setFont:[UIFont fontSmall]];
    }
    return _classHintLabel;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"default_head"];
        ViewRadius(_userImageView, CGFloatIn750(40));
    }
    return _userImageView;
}


- (UIImageView *)codeImageView {
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _codeImageView;
}


- (UIButton *)leftBtn {
    if (!_leftBtn) {
        __weak typeof(self) weakSelf = self;
        _leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_leftBtn setTitle:@"分享二维码" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont fontContent]];
        [_leftBtn bk_addEventHandler:^(id sender) {
            
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        __weak typeof(self) weakSelf = self;
        _rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_rightBtn setTitle:@"推送给教师" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont fontContent]];
        [_rightBtn bk_addEventHandler:^(id sender) {
            
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}


- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_topView, CGFloatIn750(20));
    }
    return _topView;
}

- (void)setModel:(ZOriganizationStudentCodeAddModel *)model {
    _model = model;
    [_codeImageView tt_setImageWithURL:[NSURL URLWithString:model.url]];
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _nameLabel.text = model.nick_name;
    _classLabel.text = [NSString stringWithFormat:@"班级：%@",model.class_name];
    _detailLabel.text = [NSString stringWithFormat:@"课程：%@",model.courses_name];
}
@end
