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
            
        }];
    }
    return _rightBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _bottomView;
}

@end
