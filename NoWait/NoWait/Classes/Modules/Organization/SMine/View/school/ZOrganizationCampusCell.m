//
//  ZOrganizationCampusCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusCell.h"
@interface ZOrganizationCampusCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;

@property (nonatomic,strong) UIButton *switchUserBtn;


@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZOrganizationCampusCell

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
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.leftImageView];
    [self.backContentView addSubview:self.titleLabel];
    [self.backContentView addSubview:self.subTitleLabel];
    [self.backContentView addSubview:self.switchUserBtn];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.bottom.equalTo(self);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(210));
        make.height.mas_equalTo(CGFloatIn750(132));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(16));
        make.bottom.equalTo(self.leftImageView.mas_centerY).offset(-CGFloatIn750(8));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(16));
        make.top.equalTo(self.leftImageView.mas_centerY).offset(CGFloatIn750(8));
    }];
    
    [self.switchUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontMax1Title]];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _subTitleLabel.text = @"店铺ID1324234";
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_subTitleLabel setFont:[UIFont boldFontSmall]];
    }
    return _subTitleLabel;
}


- (UIButton *)switchUserBtn {
    if (!_switchUserBtn) {
//        __weak typeof(self) weakSelf = self;
        _switchUserBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_switchUserBtn setTitle:@"切换账户" forState:UIControlStateNormal];
        [_switchUserBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_switchUserBtn.titleLabel setFont:[UIFont fontSmall]];
        UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_switchUserBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_switchUserBtn setImage:image forState:UIControlStateNormal];
        
        [_switchUserBtn bk_whenTapped:^{
            
        }];
    }
    return _switchUserBtn;
}


- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"studentDetailInfo3"];
        ViewRadius(_leftImageView, CGFloatIn750(8));
    }
    return _leftImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        ViewRadius(_backContentView, CGFloatIn750(16));
        ViewShadowRadius(_backContentView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, [UIColor colorGrayBG]);

    }
    return _backContentView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(172);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_switchUserBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
    [_switchUserBtn setImage:image forState:UIControlStateNormal];
}
@end


