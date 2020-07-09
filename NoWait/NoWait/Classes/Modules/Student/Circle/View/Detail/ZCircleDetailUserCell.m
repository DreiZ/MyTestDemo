//
//  ZCircleDetailUserCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailUserCell.h"
@interface ZCircleDetailUserCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UIButton *handleBtn;
@property (nonatomic,strong) UIImage *handleImage;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZCircleDetailUserCell

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.userImageView];
    [self.backContentView addSubview:self.nameLabel];
    [self.backContentView addSubview:self.handleBtn];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(0));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(50));
    }];
    
    [self.handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(124));
        make.height.mas_equalTo(CGFloatIn750(50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.handleBtn.mas_left).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *userBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [userBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.backContentView addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.right.equalTo(self.nameLabel.mas_right).offset(-CGFloatIn750(10));
        make.top.bottom.equalTo(self.backContentView);
    }];
    
    
    [self setType:0];
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:@"https://wx1.sinaimg.cn/mw690/7868cc4cgy1gfyviwp609j21sc1sc7wl.jpg"]];
    _nameLabel.text = @"阿萨德加感动";
}


#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UIButton *)handleBtn {
    if (!_handleBtn) {
        _handleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_handleBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_handleBtn.titleLabel setFont:[UIFont fontContent]];
        _handleBtn.imageView.tintColor = [UIColor colorMain];
        [_handleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, CGFloatIn750(4), 0, 0)];
        [_handleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, CGFloatIn750(4))];
        ViewBorderRadius(_handleBtn, CGFloatIn750(30), 1, [UIColor colorMain]);
    }
    return _handleBtn;
}

- (UIImage *)handleImage {
    if (!_handleImage) {
        _handleImage = [[UIImage imageNamed:@"finderFollowNo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        //        messageFellow finderFollowYes finderFollowNo
    }
    return _handleImage;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"default_image32"];
        ViewRadius(_userImageView, CGFloatIn750(25));
    }
    return _userImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _backContentView;
}

- (void)setType:(NSInteger)type {
    //        messageFellow finderFollowYes finderFollowNo
    if (type == 0) {
        [_handleBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]) forState:UIControlStateNormal];
        [self.handleBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        [self.handleBtn setImage:nil forState:UIControlStateNormal];
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(20));
            make.centerY.equalTo(self.backContentView.mas_centerY);
            make.width.mas_equalTo(CGFloatIn750(124));
            make.height.mas_equalTo(CGFloatIn750(50));
        }];
        ViewBorderRadius(_handleBtn, CGFloatIn750(25), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
        
    }else if(type == 1){
        [_handleBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        _handleBtn.imageView.tintColor = [UIColor colorMain];
        _handleImage = [[UIImage imageNamed:@"finderFollowYes"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [self.handleBtn setImage:_handleImage forState:UIControlStateNormal];
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(60));
            make.centerY.equalTo(self.backContentView.mas_centerY);
            make.width.mas_equalTo(CGFloatIn750(162));
            make.height.mas_equalTo(CGFloatIn750(50));
        }];
        ViewBorderRadius(_handleBtn, CGFloatIn750(25), 1, [UIColor colorMain]);
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(108);
}
@end


