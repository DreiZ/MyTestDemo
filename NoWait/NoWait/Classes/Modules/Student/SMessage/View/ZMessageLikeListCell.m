//
//  ZMessageLikeListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageLikeListCell.h"
@interface ZMessageLikeListCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UIImageView *sexImageView;
@property (nonatomic,strong) UIImageView *circleImageView;
@property (nonatomic,strong) UIImageView *likeImageView;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZMessageLikeListCell

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
    [self.backContentView addSubview:self.likeImageView];
    [self.backContentView addSubview:self.circleImageView];
    
    [self.backContentView addSubview:self.nameLabel];
    [self.backContentView addSubview:self.detailLabel];
    [self.backContentView addSubview:self.timeLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(40));
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userImageView.mas_right);
        make.bottom.equalTo(self.userImageView.mas_bottom);
        make.width.height.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(40));
        make.top.equalTo(self.userImageView.mas_top);
        make.width.height.mas_equalTo(CGFloatIn750(84));
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(28));
        make.top.equalTo(self.userImageView.mas_top).offset(CGFloatIn750(0));
        make.right.equalTo(self.circleImageView.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(14));
        make.width.height.mas_equalTo(CGFloatIn750(22));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeImageView.mas_right).offset(CGFloatIn750(8));
        make.right.equalTo(self.circleImageView.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.likeImageView.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(22));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *userBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [userBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.backContentView addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(self.userImageView.mas_top).offset(-CGFloatIn750(10));
        make.bottom.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(10));
    }];
    
    UIButton *circleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [circleBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.backContentView addSubview:circleBtn];
    [circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImageView.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(self.circleImageView.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(self.circleImageView.mas_top).offset(-CGFloatIn750(10));
        make.bottom.equalTo(self.circleImageView.mas_bottom).offset(CGFloatIn750(10));
    }];
    
    
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:@"https://wx1.sinaimg.cn/mw690/7868cc4cgy1gfyviwp609j21sc1sc7wl.jpg"]];
    _nameLabel.text = @"阿萨德加感动";
    _detailLabel.text = @"喜欢了您的动态";
    _timeLabel.text = @"17:00";
    [_circleImageView tt_setImageWithURL:[NSURL URLWithString:@"https://wx1.sinaimg.cn/mw690/7868cc4cgy1gfyviwp609j21sc1sc7wl.jpg"]];
    [ZPublicTool setLineSpacing:CGFloatIn750(12) label:self.detailLabel];
}


#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
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


- (UIImageView *)circleImageView {
    if (!_circleImageView) {
        _circleImageView = [[UIImageView alloc] init];
        _circleImageView.image = [UIImage imageNamed:@"default_loadFail276"];
    }
    return _circleImageView;
}


- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage imageNamed:@"finderLike"];
    }
    return _likeImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _backContentView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    CGSize tempSize = [@"喜欢了您的动态" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(130) - CGFloatIn750(28) - CGFloatIn750(84) - CGFloatIn750(40) - CGFloatIn750(20), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(12)];
    
    return CGFloatIn750(164) + tempSize.height - [UIFont fontSmall].lineHeight;
}
@end
