//
//  ZOrganizationDetailBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailBottomView.h"

@interface ZOrganizationDetailBottomView ()
@property (nonatomic,strong) UIButton *telBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIImageView *messageImageView;

@end

@implementation ZOrganizationDetailBottomView


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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [backView addSubview:self.telBtn];
    [backView addSubview:self.handleBtn];
    [backView addSubview:self.collectionBtn];
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backView);
        make.width.mas_equalTo(CGFloatIn750(128));
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(self.telBtn.mas_right);
        make.width.mas_equalTo(CGFloatIn750(128));
    }];
    
    [self.handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(backView);
        make.left.equalTo(self.collectionBtn.mas_right);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIButton *)handleBtn {
    if (!_handleBtn) {
        _handleBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        _handleBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_handleBtn setTitle:@"预约体验" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_handleBtn.titleLabel setFont:[UIFont boldFontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_handleBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _handleBtn;
}


- (UIButton *)telBtn {
    if (!_telBtn) {
        _telBtn = [[ZButton alloc] initWithFrame:CGRectZero];
//        [_telBtn setImage:[UIImage imageNamed:@"telGray"] forState:UIControlStateNormal];
        UIImageView *telImage = [[UIImageView alloc] init];
        telImage.image = [UIImage imageNamed:@"telGray"];
        telImage.layer.masksToBounds = YES;
        [_telBtn addSubview:telImage];
        [telImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.telBtn);
            make.height.mas_equalTo(CGFloatIn750(34));
            make.width.mas_equalTo(CGFloatIn750(26));
        }];
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _telBtn;
}


- (UIButton *)collectionBtn {
    if (!_collectionBtn) {
        _collectionBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_collectionBtn addSubview:self.messageImageView];
        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.collectionBtn);
            make.width.height.mas_equalTo(CGFloatIn750(32));
        }];
        
        __weak typeof(self) weakSelf = self;
        [_collectionBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
//        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
//        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
//        [_collectionBtn addSubview:bottomLineView];
//        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.top.equalTo(self.collectionBtn);
//            make.width.mas_equalTo(1);
//        }];
    }
    return _collectionBtn;
}

- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.image = [UIImage imageNamed:@"handleStore"];
        _messageImageView.layer.masksToBounds = YES;
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _messageImageView;
}

- (void)setTitle:(NSString *)title {
    [_handleBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setIsCollection:(BOOL)isCollection {
    _isCollection = isCollection;
    _messageImageView.image = isCollection ? [UIImage imageNamed:@"collectionHandle"]:[UIImage imageNamed:@"handleStore"];
}
@end
