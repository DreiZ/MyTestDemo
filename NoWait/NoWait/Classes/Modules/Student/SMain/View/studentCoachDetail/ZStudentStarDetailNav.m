//
//  ZStudentStarDetailNav.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarDetailNav.h"

@interface ZStudentStarDetailNav ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *arrowBtn;
@property (nonatomic,strong) UIView *contView;

@end

@implementation ZStudentStarDetailNav

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorBlueMoment];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
//    UIImageView *backgroundImageView = [[UIImageView alloc] init];
//    backgroundImageView.image = [UIImage imageNamed:@"studentStarHeaderBack"];
//    backgroundImageView.layer.masksToBounds = YES;
//    [self addSubview:backgroundImageView];
//    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(CGFloatIn750(500));
//        make.left.right.top.equalTo(self);
//    }];
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    [self.contView addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.contView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
}

#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
//        _contView.backgroundColor = [UIColor colorBlueMoment];
    }
    return _contView;
}

- (UIButton *)arrowBtn {
    if (!_arrowBtn) {
        __weak typeof(self) weakSelf = self;
        _arrowBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_arrowBtn setImage:[UIImage imageNamed:@"leftWhiteArrow"] forState:UIControlStateNormal];
        [_arrowBtn bk_whenTapped:^{
            if (weakSelf.backBlock) {
                weakSelf.backBlock(0);
            }
        }];
    }
    return _arrowBtn;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWhite];
        _titleLabel.text = @"学员详情";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontTitle]];
    }
    return _titleLabel;
}


#pragma mark -设置数据
-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
@end
