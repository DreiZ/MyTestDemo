//
//  ZTeacherSignStudentListBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherSignStudentListBottomView.h"

@interface ZTeacherSignStudentListBottomView ()
@property (nonatomic,strong) UIButton *signBtn;
@property (nonatomic,strong) UIButton *qingBtn;
@property (nonatomic,strong) UIButton *kuangBtn;
@property (nonatomic,strong) UIButton *buBtn;
@end

@implementation ZTeacherSignStudentListBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.signBtn];
    [self addSubview:self.qingBtn];
    [self addSubview:self.kuangBtn];
    [self addSubview:self.buBtn];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(KScreenWidth/4.0f);
    }];
    ;
    [self.qingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.signBtn.mas_right);
        make.width.mas_equalTo(KScreenWidth/4.0f);
    }];
    
    [self.kuangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.qingBtn.mas_right);
        make.width.mas_equalTo(KScreenWidth/4.0f);
    }];
    
    [self.buBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.kuangBtn.mas_right);
        make.width.mas_equalTo(KScreenWidth/4.0f);
    }];
}


- (UIButton *)signBtn {
    if (!_signBtn) {
        __weak typeof(self) weakSelf = self;
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_signBtn setTitle:@"  签课" forState:UIControlStateNormal];
        [_signBtn setImage:[UIImage imageNamed:@"signzheng"] forState:UIControlStateNormal];
        [_signBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        [_signBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _signBtn;
}


- (UIButton *)qingBtn {
    if (!_qingBtn) {
        __weak typeof(self) weakSelf = self;
        _qingBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_qingBtn setTitle:@"  请假" forState:UIControlStateNormal];
        [_qingBtn setImage:[UIImage imageNamed:@"signqing"] forState:UIControlStateNormal];
        [_qingBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_qingBtn.titleLabel setFont:[UIFont fontContent]];
        [_qingBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        }];
    }
    return _qingBtn;
}


- (UIButton *)kuangBtn {
    if (!_kuangBtn) {
        __weak typeof(self) weakSelf = self;
        _kuangBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_kuangBtn setTitle:@"  旷课" forState:UIControlStateNormal];
        [_kuangBtn setImage:[UIImage imageNamed:@"signkuang"] forState:UIControlStateNormal];
        [_kuangBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_kuangBtn.titleLabel setFont:[UIFont fontContent]];
        [_kuangBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            };
        }];
    }
    return _kuangBtn;
}


- (UIButton *)buBtn {
    if (!_buBtn) {
        __weak typeof(self) weakSelf = self;
        _buBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_buBtn setTitle:@"  补签" forState:UIControlStateNormal];
        [_buBtn setImage:[UIImage imageNamed:@"signbu"] forState:UIControlStateNormal];
        [_buBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_buBtn.titleLabel setFont:[UIFont fontContent]];
        [_buBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(3);
            };
        }];
    }
    return _buBtn;
}

- (void)setType:(NSString *)type {
    
    self.signBtn.hidden = YES;
    self.qingBtn.hidden = YES;
    self.kuangBtn.hidden = YES;
    self.buBtn.hidden = YES;
//    1：签课 2：教师代签 3：补签 4：请假 5：旷课
    if ([type intValue] == 6) {
        self.signBtn.hidden = NO;
        self.qingBtn.hidden = NO;
        self.kuangBtn.hidden = NO;
        [self.signBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left);
            make.width.mas_equalTo(KScreenWidth/3.0f);
        }];
        
        [self.qingBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.signBtn.mas_right);
            make.width.mas_equalTo(KScreenWidth/3.0f);
        }];
        
        [self.kuangBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.qingBtn.mas_right);
            make.width.mas_equalTo(KScreenWidth/3.0f);
        }];
    }else if([type intValue] == 4 || [type intValue] == 5){
        self.buBtn.hidden = NO;
        [self.buBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.right.equalTo(self);
        }];
    }
}
@end
