//
//  ZInvitationFriendVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZInvitationFriendVC.h"

@interface ZInvitationFriendVC ()
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *erwermaImageView;
@property (nonatomic,strong) UIView *contView;

@end

@implementation ZInvitationFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"邀请好友"];
}

- (void)setMainView {
    self.view.backgroundColor = HexColor(0xc6e2e3);
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.bottomView addSubview:self.leftBtn];
    [self.bottomView addSubview:self.rightBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_centerX);
    }];

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView.mas_centerX).offset(0.5);
    }];
    
    [self.view addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"moneyIntroBack"];
    backImageView.layer.masksToBounds = YES;
    [self.contView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"moneyIntroTop"];
    topImageView.layer.masksToBounds = YES;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(120));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(504));
        make.height.mas_equalTo(CGFloatIn750(254));
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    bottomImageView.image = [UIImage imageNamed:@"moneyIntroBottom"];
    bottomImageView.layer.masksToBounds = YES;
    [self.view addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(50));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(272));
        make.height.mas_equalTo(CGFloatIn750(50));
    }];
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.image = [UIImage imageNamed:@"moneyIntroLeft"];
    leftImageView.layer.masksToBounds = YES;
    [self.view addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomImageView.mas_top).offset(-CGFloatIn750(66));
        make.left.equalTo(self.view.mas_left);
    }];
    
    UIImageView *midImageView = [[UIImageView alloc] init];
    midImageView.image = [UIImage imageNamed:@"moneyIntroRMid"];
    midImageView.layer.masksToBounds = YES;
    [self.view addSubview:midImageView];
    [midImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomImageView.mas_top).offset(-CGFloatIn750(66));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"moneyIntroRight"];
    rightImageView.layer.masksToBounds = YES;
    [self.view addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomImageView.mas_top).offset(-CGFloatIn750(66));
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.view addSubview:self.erwermaImageView];
    [self.erwermaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(280));
        make.centerY.equalTo(leftImageView.mas_top);
    }];
    
    [self.erwermaImageView tt_setImageWithURL:[NSURL URLWithString:_model.qrcode]];
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        __weak typeof(self) weakSelf = self;
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftBtn setTitle:@"复制邀请链接" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayBG]) forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont fontContent]];
        _leftBtn.backgroundColor = [UIColor colorMain];
        [_leftBtn bk_whenTapped:^{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = weakSelf.model.inviter_url;
        }];
    }
    return _leftBtn;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        __weak typeof(self) weakSelf = self;
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightBtn setTitle:@"保存图片到相册" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayBG]) forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont fontContent]];
        _rightBtn.backgroundColor = [UIColor colorMain];
        [_rightBtn bk_whenTapped:^{
            UIImage *shortImage = [ZPublicTool snapshotForView:weakSelf.view];
            if (shortImage) {
                [ZPublicTool saveImageToPhoto:shortImage];
            }
        }];
    }
    return _rightBtn;
}


- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _bottomView;
}

- (UIImageView *)erwermaImageView {
    if (!_erwermaImageView) {
        _erwermaImageView = [[UIImageView alloc] init];
        _erwermaImageView.layer.masksToBounds = YES;
        _erwermaImageView.contentMode = UIViewContentModeScaleAspectFit;
        _erwermaImageView.backgroundColor = [UIColor colorMain];
    }
    return _erwermaImageView;
}
@end
