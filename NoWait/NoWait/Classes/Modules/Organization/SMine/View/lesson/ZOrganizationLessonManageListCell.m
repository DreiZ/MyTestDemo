//
//  ZOrganizationLessonManageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonManageListCell.h"

@interface ZOrganizationLessonManageListCell ()

@property (nonatomic,strong) UILabel *lessonNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *lessonStatelabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UILabel *salesNumLabel;

@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *openBtn;

@end

@implementation ZOrganizationLessonManageListCell

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
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    [topView addSubview:self.lessonStatelabel];
    [self.lessonStatelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [midView addSubview:self.leftImageView];
    [midView addSubview:self.priceLabel];
    [midView addSubview:self.salesNumLabel];
    [midView addSubview:self.lessonNameLabel];
    [midView addSubview:self.scoreLabel];

   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];

    [self.lessonNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonNameLabel.mas_left);
        make.top.equalTo(self.leftImageView.mas_centerY).offset(CGFloatIn750(0));
        make.right.equalTo(midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonNameLabel.mas_left);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(CGFloatIn750(16));
    }];

    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(midView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.salesNumLabel.mas_centerY);
    }];

    
    [bottomView addSubview:self.editBtn];
    [bottomView addSubview:self.openBtn];
    [bottomView addSubview:self.closeBtn];
    [bottomView addSubview:self.delBtn];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(116));
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(self.editBtn.mas_left).offset(CGFloatIn750(-20));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(172));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(self.openBtn.mas_left).offset(CGFloatIn750(-20));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(172));
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(self.closeBtn.mas_left).offset(CGFloatIn750(-20));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(116));
    }];
}


#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(12));
    }
    return _contView;
}

- (UILabel *)lessonNameLabel {
    if (!_lessonNameLabel) {
        _lessonNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _lessonNameLabel.text = @"开放课程";
        _lessonNameLabel.numberOfLines = 1;
        _lessonNameLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonNameLabel setFont:[UIFont boldFontTitle]];
    }
    return _lessonNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorRedForButton],[UIColor colorRedForButton]);
        _priceLabel.text = @"$345";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"serverTopbg"];
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}


- (UILabel *)salesNumLabel {
    if (!_salesNumLabel) {
        _salesNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _salesNumLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _salesNumLabel.text = @"已售20";
        _salesNumLabel.numberOfLines = 1;
        _salesNumLabel.textAlignment = NSTextAlignmentLeft;
        [_salesNumLabel setFont:[UIFont fontSmall]];
    }
    return _salesNumLabel;
}


- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scoreLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _scoreLabel.text = @"4.0分";
        _scoreLabel.numberOfLines = 1;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
        [_scoreLabel setFont:[UIFont fontSmall]];
    }
    return _scoreLabel;
}


- (UILabel *)lessonStatelabel {
    if (!_lessonStatelabel) {
        _lessonStatelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _lessonStatelabel.text = @"人满开课";
        _lessonStatelabel.numberOfLines = 1;
        _lessonStatelabel.textAlignment = NSTextAlignmentLeft;
        [_lessonStatelabel setFont:[UIFont fontSmall]];
    }
    return _lessonStatelabel;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_editBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_editBtn, CGFloatIn750(28), CGFloatIn750(2), [UIColor colorMain]);
    }
    return _editBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setTitle:@"关闭课程" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_closeBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    }
    return _closeBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    }
    return _delBtn;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn setTitle:@"开放课程" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_openBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_openBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
    }
    return _openBtn;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(404);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}
@end


