//
//  ZCircleMyFocusCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyFocusCell.h"
@interface ZCircleMyFocusCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *subnameLabel;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UIImageView *sexImageView;

@property (nonatomic,strong) UIButton *handleBtn;
@property (nonatomic,strong) UIImage *handleImage;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZCircleMyFocusCell

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
    [self.backContentView addSubview:self.userImageView];
    [self.backContentView addSubview:self.sexImageView];
    
    [self.backContentView addSubview:self.nameLabel];
    [self.backContentView addSubview:self.subnameLabel];
    
    [self.backContentView addSubview:self.handleBtn];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(0));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(40));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userImageView.mas_right);
        make.bottom.equalTo(self.userImageView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(60));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(162));
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.handleBtn.mas_left).offset(-CGFloatIn750(16));
        make.bottom.equalTo(self.userImageView.mas_centerY).offset(-CGFloatIn750(2));
    }];
    
    [self.subnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.handleBtn.mas_left).offset(-CGFloatIn750(16));
        make.top.equalTo(self.userImageView.mas_centerY).offset(CGFloatIn750(8));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.backContentView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.handleBtn.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(self.handleBtn.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(self.handleBtn.mas_top).offset(-CGFloatIn750(10));
        make.bottom.equalTo(self.handleBtn.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(0.5);
    }];
    
    [self setType:0];
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:@"https://wx1.sinaimg.cn/mw690/7868cc4cgy1gfyviwp609j21sc1sc7wl.jpg"]];
    _nameLabel.text = @"阿萨德加感动";
    _subnameLabel.text = @"噶是的感受到公司的";
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


- (UILabel *)subnameLabel {
    if (!_subnameLabel) {
        _subnameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subnameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _subnameLabel.numberOfLines = 1;
        _subnameLabel.textAlignment = NSTextAlignmentLeft;
        [_subnameLabel setFont:[UIFont fontSmall]];
    }
    return _subnameLabel;
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

- (UIImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] init];
        _sexImageView.image = [UIImage imageNamed:@"finderGirl"];
//        finderMan
    }
    return _sexImageView;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"default_image32"];
        ViewRadius(_userImageView, CGFloatIn750(45));
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
        [_handleBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        _handleBtn.imageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _handleImage = [[UIImage imageNamed:@"finderFollowYes"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.handleBtn setImage:_handleImage forState:UIControlStateNormal];
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(60));
            make.centerY.equalTo(self.backContentView.mas_centerY);
            make.width.mas_equalTo(CGFloatIn750(162));
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        ViewBorderRadius(_handleBtn, CGFloatIn750(30), 1, adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    }else if(type == 1){
        [_handleBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        _handleBtn.imageView.tintColor = [UIColor colorMain];
        _handleImage = [[UIImage imageNamed:@"finderFollowNo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [self.handleBtn setImage:_handleImage forState:UIControlStateNormal];
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(60));
            make.centerY.equalTo(self.backContentView.mas_centerY);
            make.width.mas_equalTo(CGFloatIn750(162));
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        ViewBorderRadius(_handleBtn, CGFloatIn750(30), 1, [UIColor colorMain]);
    }else{
        [_handleBtn setTitle:@"互相关注" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        _handleBtn.imageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _handleImage = [[UIImage imageNamed:@"messageFellow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [self.handleBtn setImage:_handleImage forState:UIControlStateNormal];
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(60));
            make.centerY.equalTo(self.backContentView.mas_centerY);
            make.width.mas_equalTo(CGFloatIn750(180));
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        ViewBorderRadius(_handleBtn, CGFloatIn750(30), 1, adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(150);
}
@end

