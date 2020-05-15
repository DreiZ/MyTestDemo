//
//  ZOrganizationMineHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineHeaderView.h"

#define headImageHeight CGFloatIn750(120)
#define settingImageHeight CGFloatIn750(80)


@interface ZOrganizationMineHeaderView ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *midLabel;
@property (nonatomic,strong) UIView *settingView;
@property (nonatomic,strong) UIImageView *settingImageView;

@property (nonatomic,strong) UIButton *userInfoBtn;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIButton *switchUserBtn;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UIView *stateBackView;
@property (nonatomic,strong) UIButton *stateBtn;

@property (nonatomic,strong) UIView *scanView;
@property (nonatomic,strong) UIImageView *scanQRCodeImageView;
@property (nonatomic,strong) UIButton *qrCodeBtn;
@property (nonatomic,strong) UIButton *rewardBtn;


@end

@implementation ZOrganizationMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.settingView];
    [self.settingView addSubview:self.settingImageView];
    [self addSubview:self.switchUserBtn];
    [self addSubview:self.stateLabel];
    [self addSubview:self.midLabel];
    [self addSubview:self.scanView];
    [self addSubview:self.rewardBtn];
    [self.scanView addSubview:self.scanQRCodeImageView];
    
    [self addSubview:self.stateBackView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self.settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.settingView);
        make.height.width.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.scanQRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.scanView);
        make.height.width.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top).offset(CGFloatIn750(12));
        make.left.equalTo(self.headImageView.mas_right).offset(CGFloatIn750(20));
        make.width.mas_lessThanOrEqualTo(KScreenWidth - headImageHeight - CGFloatIn750(60) - CGFloatIn750(54) - CGFloatIn750(136) - CGFloatIn750(20) * 2);
    }];
    
    [self.switchUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.nameLabel.mas_centerY).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(54));
    }];
    
    
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midLabel.mas_left).offset(CGFloatIn750(14));
        make.top.equalTo(self.midLabel.mas_bottom).offset(CGFloatIn750(8));
        make.height.mas_equalTo(CGFloatIn750(54));
    }];
    
    [self.rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.headImageView.mas_centerY).offset(CGFloatIn750(16));
        make.height.mas_equalTo(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(136));
    }];
    ViewShadowRadius(self.rewardBtn, CGFloatIn750(20), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
    
    [self.stateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(32));
        make.left.equalTo(self.stateLabel.mas_left).offset(-CGFloatIn750(14));
        make.right.equalTo(self.stateLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.stateLabel.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *userBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [userBtn bk_whenTapped:^{
        if (weakSelf.topHandleBlock) {
            weakSelf.topHandleBlock(10);
        }
    }];
    [self addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headImageView);
    }];
    
    [self addSubview:self.userInfoBtn];
    [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.userInfoBtn);
    }];
    
    
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [setBtn bk_whenTapped:^{
        if (weakSelf.topHandleBlock) {
            weakSelf.topHandleBlock(1);
        }
    }];
    [self addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(80));
        make.center.equalTo(self.settingView);
    }];
    
    
    [self addSubview:self.qrCodeBtn];
    [self.qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(80));
        make.center.equalTo(self.scanView);
    }];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [switchBtn bk_whenTapped:^{
        if (weakSelf.topHandleBlock) {
            weakSelf.topHandleBlock(3);
        }
    }];
    [self addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.switchUserBtn.mas_left).offset(CGFloatIn750(-40));
        make.right.equalTo(self.switchUserBtn.mas_right).offset(CGFloatIn750(40));
        make.top.equalTo(self.switchUserBtn.mas_top).offset(CGFloatIn750(-30));
        make.bottom.equalTo(self.switchUserBtn.mas_bottom).offset(CGFloatIn750(30));
    }];
    
    [self addSubview:self.stateBtn];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stateBackView.mas_left).offset(CGFloatIn750(-20));
        make.right.equalTo(self.stateBackView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.stateBackView.mas_top).offset(CGFloatIn750(-20));
        make.bottom.equalTo(self.stateBackView.mas_bottom).offset(CGFloatIn750(20));
    }];
    [self setSubViewFrame];
}

#pragma mark -设置frame
- (void)setSubViewFrame {
    self.settingImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
    self.scanView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
    
//    self.headImageView.frame = CGRectMake(KScreenWidth - headImageHeight -  CGFloatIn750(30), self.height - CGFloatIn750(38) - headImageHeight, headImageHeight, headImageHeight);
    self.headImageView.frame = CGRectMake(CGFloatIn750(30), self.height - CGFloatIn750(38) - headImageHeight - [ZOrganizationMineHeaderView getNameOffset], headImageHeight, headImageHeight);
    
    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight, self.height - CGFloatIn750(180) - settingImageHeight, settingImageHeight, settingImageHeight);
    
    self.scanView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight - CGFloatIn750(80) - CGFloatIn750(0), self.height - CGFloatIn750(180) - settingImageHeight, settingImageHeight, settingImageHeight);
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
    self.nameLabel.alpha = 1;
    self.midLabel.alpha = 1;
    self.headImageView.layer.cornerRadius = headImageHeight/2.0f;
    
    self.backView.alpha = 0;
    self.switchUserBtn.alpha = 1;
    self.rewardBtn.alpha = 1;
}

- (void)setAnimationSubViewFrame {
   
    CGFloat alpha =  1 - ((kTopHeight + kStatusBarHeight * 2) - self.height)/kTopHeight;
    
    self.nameLabel.alpha = alpha;
    self.switchUserBtn.alpha = alpha;
    self.stateLabel.alpha = alpha;
    self.stateBackView.alpha = alpha;
    self.rewardBtn.alpha = alpha;
    self.midLabel.alpha = alpha;
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(32) - (1-self.nameLabel.alpha)*CGFloatIn750(20)];
    
    CGFloat changeHeadImageHeight = headImageHeight- (1-self.nameLabel.alpha)*CGFloatIn750(60);
     
//    self.headImageView.frame = CGRectMake(KScreenWidth - changeHeadImageHeight -  CGFloatIn750(30) - (KScreenWidth/2.0 - changeHeadImageHeight/2.0 -  CGFloatIn750(30)) * (1-alpha) + [ZOrganizationMineHeaderView getNameOffset]*(1-alpha), self.height - (CGFloatIn750(38) - (1-alpha)*CGFloatIn750(14)) - changeHeadImageHeight, changeHeadImageHeight, changeHeadImageHeight);
    self.headImageView.frame = CGRectMake(CGFloatIn750(30), self.height - CGFloatIn750(38) + (1-alpha)*CGFloatIn750(14) - changeHeadImageHeight - [ZOrganizationMineHeaderView getNameOffset] + [ZOrganizationMineHeaderView getNameOffset]*(1-alpha), changeHeadImageHeight, changeHeadImageHeight);

    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight, self.height - CGFloatIn750(180) - settingImageHeight + ((1-alpha) * CGFloatIn750(170)), settingImageHeight, settingImageHeight);
    
    self.scanView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight - CGFloatIn750(80) - CGFloatIn750(0), self.height - CGFloatIn750(180) - settingImageHeight + ((1-alpha) * CGFloatIn750(170)), settingImageHeight, settingImageHeight);
    
    self.headImageView.layer.cornerRadius = self.headImageView.height/2;
    self.settingImageView.transform = CGAffineTransformRotate(self.settingImageView.transform, M_PI_4 * 0.05);
    
    self.backView.alpha = (1 - alpha);
    
    if (!isDarkModel()) {
        self.settingImageView.tintColor = [UIColor colorWithWhite:(1-alpha) alpha:1];
    }else{
        self.settingImageView.tintColor = [UIColor colorWithWhite:(0.9) alpha:1];
    }
    
    if (!isDarkModel()) {
        self.scanQRCodeImageView.tintColor = [UIColor colorWithWhite:(1-alpha) alpha:1];
    }else{
        self.scanQRCodeImageView.tintColor = [UIColor colorWithWhite:(0.9) alpha:1];
    }
    
//    if (!isDarkModel()) {
//        self.midLabel.textColor = [UIColor colorWithWhite:(1-alpha) alpha:1];
//    }else{
//        self.midLabel.textColor = [UIColor colorWithWhite:(0.9) alpha:1];
//    }
    
    self.qrCodeBtn.hidden = YES;
//    self.scanQRCodeImageView.hidden = YES;
//    self.scanView.hidden = YES;
}

#pragma mark - - 懒加载---
- (UIButton *)stateBtn {
    if (!_stateBtn) {
        __weak typeof(self) weakSelf = self;
        _stateBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_stateBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(5);
            }
        }];
    }
    return _stateBtn;
}

- (UIButton *)qrCodeBtn {
    if (!_qrCodeBtn) {
        __weak typeof(self) weakSelf = self;
        _qrCodeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_qrCodeBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(8);
            }
        }];
    }
    return _qrCodeBtn;
}


- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = headImageHeight/2.0f;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)midLabel {
    if (!_midLabel) {
        _midLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _midLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _midLabel.numberOfLines = 1;
        _midLabel.textAlignment = NSTextAlignmentLeft;
        [_midLabel setFont:[UIFont fontSmall]];
    }
    return _midLabel;
}

- (UIImageView *)settingImageView {
    if (!_settingImageView) {
        _settingImageView = [[UIImageView alloc] init];
        _settingImageView.image = [[UIImage imageNamed:@"mineSetting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _settingImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
        _settingImageView.layer.masksToBounds = YES;
        _settingImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _settingImageView;
}


- (UIImageView *)scanQRCodeImageView {
    if (!_scanQRCodeImageView) {
        _scanQRCodeImageView = [[UIImageView alloc] init];
        _scanQRCodeImageView.image = [[UIImage imageNamed:@"scanQRCode"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _scanQRCodeImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
        _scanQRCodeImageView.layer.masksToBounds = YES;
        _scanQRCodeImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _scanQRCodeImageView;
}

- (UIButton *)userInfoBtn {
    if (!_userInfoBtn) {
        __weak typeof(self) weakSelf = self;
        _userInfoBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_userInfoBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(0);
            }
        }];
    }
    return _userInfoBtn;
}

- (UIButton *)switchUserBtn {
    if (!_switchUserBtn) {
        __weak typeof(self) weakSelf = self;
        UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_switchUserBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        _switchUserBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_switchUserBtn setTitle:@"" forState:UIControlStateNormal];
        [_switchUserBtn setImage:image forState:UIControlStateNormal];
        [_switchUserBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_switchUserBtn.titleLabel setFont:[UIFont fontSmall]];
        [_switchUserBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(3);
            }
        }];
    }
    return _switchUserBtn;
}

- (UIButton *)rewardBtn {
    if (!_rewardBtn) {
        __weak typeof(self) weakSelf = self;
        _rewardBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _rewardBtn.backgroundColor = [UIColor colorMain];
        ViewRadius(_rewardBtn, CGFloatIn750(20));
        [_rewardBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(12);
            }
        }];
        
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = [UIColor colorWhite];
        hintLabel.text = @"奖励中心";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentLeft;
        [hintLabel setFont:[UIFont fontMin]];
        [_rewardBtn addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rewardBtn.mas_centerY);
            make.left.equalTo(self.rewardBtn.mas_left).offset(CGFloatIn750(20));
        }];
        
        UIImageView *hintImage = [[UIImageView alloc] init];
        hintImage.image = [[UIImage imageNamed:@"rightGrayArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hintImage.tintColor = [UIColor colorWhite];
        hintImage.layer.masksToBounds = YES;
        [_rewardBtn addSubview:hintImage];
        [hintImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(9));
            make.height.mas_equalTo(CGFloatIn750(12));
            make.centerY.equalTo(self.rewardBtn.mas_centerY);
            make.right.equalTo(self.rewardBtn.mas_right).offset(-CGFloatIn750(14));
        }];
    }
    return _rewardBtn;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _stateLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _stateLabel.text = @"总账户";
        _stateLabel.numberOfLines = 1;
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        [_stateLabel setFont:[UIFont fontMin]];
    }
    return _stateLabel;
}

- (UIView *)settingView {
    if (!_settingView) {
        _settingView = [[UIView alloc] init];
        _settingView.layer.masksToBounds = YES;
//        _settingView.backgroundColor =[UIColor colorWhite];
    }
    return _settingView;
}

- (UIView *)scanView {
    if (!_scanView) {
        _scanView = [[UIView alloc] init];
        _scanView.layer.masksToBounds = YES;
//        _scanView.backgroundColor =[UIColor colorWhite];
    }
    return _scanView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _backView;
}

- (UIView *)stateBackView {
    if (!_stateBackView) {
        _stateBackView = [[UIView alloc] init];
        _stateBackView.layer.masksToBounds = YES;
        _stateBackView.layer.cornerRadius = CGFloatIn750(16);
        _stateBackView.layer.borderColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]).CGColor;
        _stateBackView.layer.borderWidth = 1;
    }
    return _stateBackView;
}

#pragma mark - 更新frame
- (void)updateSubViewFrame {
    [self setSubViewFrame];
    if (self.height > kTopHeight + kStatusBarHeight * 2) {
        [self setSubViewFrame];
    }else {
        [self setAnimationSubViewFrame];
    }
}

- (void)updateData {
    NSString *name = @"游客";
    if ([ZUserHelper sharedHelper].user) {
        name = SafeStr([ZUserHelper sharedHelper].user.nikeName).length > 0 ? SafeStr([ZUserHelper sharedHelper].user.nikeName) : SafeStr([ZUserHelper sharedHelper].user.phone);;
    }
    [self.headImageView tt_setImageWithURL:[NSURL URLWithString:SafeStr([ZUserHelper sharedHelper].user.avatar)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    self.nameLabel.text = name;
    _midLabel.text = [NSString stringWithFormat:@"MID：%@",ValidStr([ZUserHelper sharedHelper].uuid)?[ZUserHelper sharedHelper].uuid :@"0000000"];
    
    NSString *typestr = @"学员端";
    //    1：学员 2：教师 6：校区 8：机构
    _stateLabel.hidden = YES;
    _stateBackView.hidden = YES;
    _stateBtn.hidden = YES;
    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
        typestr = @"学员端";
    }else if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
        typestr = @"教师端";
    }else if ([[ZUserHelper sharedHelper].user.type intValue] == 6) {
        typestr = @"校区端";
    }else if ([[ZUserHelper sharedHelper].user.type intValue] == 8) {
        typestr = @"总账户";
        _stateLabel.hidden = NO;
        _stateBackView.hidden = NO;
        _stateLabel.hidden = NO;
        _stateBtn.hidden = NO;
    }
    _stateLabel.text = typestr;
}

- (void)setUserType:(NSString *)userType {
    _userType = userType;
    if ([userType intValue] == 1 || [userType intValue] == 2) {
        self.scanQRCodeImageView.hidden = NO;
        self.scanView.hidden = NO;
        self.qrCodeBtn.hidden = NO;
    }else{
        self.scanQRCodeImageView.hidden = YES;
        self.scanView.hidden = YES;
        self.qrCodeBtn.hidden = YES;
    }
}

+ (CGFloat)getNameOffset {
    if ([ZUserHelper sharedHelper].user) {
        CGSize nameSize = [[ZUserHelper sharedHelper].user.nikeName tt_sizeWithFont:[UIFont boldSystemFontOfSize:CGFloatIn750(32)] constrainedToSize:CGSizeMake((KScreenWidth - headImageHeight - CGFloatIn750(60) - CGFloatIn750(54) - CGFloatIn750(136) - CGFloatIn750(20) * 2), MAXFLOAT)];
        CGSize oneSize = [@"行行行" tt_sizeWithFont:[UIFont boldSystemFontOfSize:CGFloatIn750(32)] constrainedToSize:CGSizeMake(KScreenWidth, MAXFLOAT)];
        return nameSize.height - oneSize.height;
    }
    return 0;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_switchUserBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
    [_switchUserBtn setImage:image forState:UIControlStateNormal];
    _settingImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
    _scanQRCodeImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
}
@end
