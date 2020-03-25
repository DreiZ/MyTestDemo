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
@property (nonatomic,strong) UIView *settingView;
@property (nonatomic,strong) UIImageView *settingImageView;

@property (nonatomic,strong) UIButton *userInfoBtn;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIButton *switchUserBtn;
@property (nonatomic,strong) UILabel *stateLabel;
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
    
    UIView *stateBackView = [[UIView alloc] init];
    stateBackView.layer.masksToBounds = YES;
    stateBackView.layer.cornerRadius = CGFloatIn750(16);
    stateBackView.layer.borderColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]).CGColor;
    stateBackView.layer.borderWidth = 1;
    [self addSubview:stateBackView];
    
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
    [self.settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.settingView);
        make.height.width.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImageView.mas_centerY).offset(-CGFloatIn750(20));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(24));
    }];
    
    [self.switchUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(8));
        make.height.mas_equalTo(CGFloatIn750(54));
    }];
    
    [stateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(32));
        make.left.equalTo(self.stateLabel.mas_left).offset(-CGFloatIn750(14));
        make.right.equalTo(self.stateLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.stateLabel.mas_centerY);
    }];
    
    [self addSubview:self.userInfoBtn];
    [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.userInfoBtn);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [setBtn bk_whenTapped:^{
        if (weakSelf.topHandleBlock) {
            weakSelf.topHandleBlock(1);
        }
    }];
    [self addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.center.equalTo(self.settingView);
    }];
    
    [self setSubViewFrame];
}

#pragma mark -设置frame
- (void)setSubViewFrame {
    self.settingImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1));
    self.headImageView.frame = CGRectMake(KScreenWidth - headImageHeight -  CGFloatIn750(30), self.height - CGFloatIn750(38) - headImageHeight, headImageHeight, headImageHeight);
    
    
    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight, self.height - CGFloatIn750(180) - settingImageHeight, settingImageHeight, settingImageHeight);
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(36)];
    self.nameLabel.alpha = 1;
    self.headImageView.layer.cornerRadius = CGFloatIn750(41);
    
    self.backView.alpha = 0;
    self.switchUserBtn.alpha = 1;
}

- (void)setAnimationSubViewFrame {
   
    CGFloat alpha =  1 - ((kTopHeight + kStatusBarHeight * 2) - self.height)/kTopHeight;
    
    self.nameLabel.alpha = alpha;
    self.switchUserBtn.alpha = alpha;
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(36) - (1-self.nameLabel.alpha)*CGFloatIn750(20)];
    
    CGFloat changeHeadImageHeight = headImageHeight- (1-self.nameLabel.alpha)*CGFloatIn750(60);
     
    self.headImageView.frame = CGRectMake(KScreenWidth - changeHeadImageHeight -  CGFloatIn750(30) - (KScreenWidth/2.0 - changeHeadImageHeight/2.0 -  CGFloatIn750(30)) * (1-alpha), self.height - (CGFloatIn750(38) - (1-alpha)*CGFloatIn750(14)) - changeHeadImageHeight, changeHeadImageHeight, changeHeadImageHeight);
    
    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(44) - settingImageHeight, self.height - CGFloatIn750(180) - settingImageHeight + ((1-alpha) * CGFloatIn750(170)), settingImageHeight, settingImageHeight);
    
    self.headImageView.layer.cornerRadius = self.headImageView.height/2;
    self.settingImageView.transform = CGAffineTransformRotate(self.settingImageView.transform, M_PI_4 * 0.05);
    
    self.backView.alpha = (1 - alpha);
    
    if (!isDarkModel()) {
        self.settingImageView.tintColor = [UIColor colorWithWhite:(1-alpha) alpha:1];
    }else{
        self.settingImageView.tintColor = [UIColor colorWithWhite:(0.9) alpha:1];
    }
    
}

#pragma mark --懒加载---
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = CGFloatIn750(41);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontMaxTitle]];
    }
    return _nameLabel;
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
        [_switchUserBtn setTitle:@"切换账户" forState:UIControlStateNormal];
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

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _backView;
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
    [self.headImageView tt_setImageWithURL:[NSURL URLWithString:SafeStr([ZUserHelper sharedHelper].user.avatar)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    self.nameLabel.text = SafeStr([ZUserHelper sharedHelper].user.nikeName).length > 0 ? SafeStr([ZUserHelper sharedHelper].user.nikeName) : SafeStr([ZUserHelper sharedHelper].user.phone);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_switchUserBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
    [_switchUserBtn setImage:image forState:UIControlStateNormal];
    _settingImageView.tintColor = adaptAndDarkColor(HexAColor(0x000000, 1), HexAColor(0xeeeeee, 1)) ;
}
@end
