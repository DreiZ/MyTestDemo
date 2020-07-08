//
//  ZStudentMessageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageListCell.h"

@interface ZStudentMessageListCell ()
@property (nonatomic,strong) UIImageView *messageImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation ZStudentMessageListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.messageImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.numLabel];
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(40));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(32));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-40));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(52));
        make.width.height.mas_equalTo(CGFloatIn750(32));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageImageView.mas_right).offset(CGFloatIn750(22));
        make.top.equalTo(self.messageImageView.mas_top).offset(CGFloatIn750(4));
        make.right.equalTo(self.timeLabel.mas_left).offset(-CGFloatIn750(10));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.titleLabel.mas_right);
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
    
    NSArray *temp = @[@"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdtzaw1o9j31920u012l.jpg",
        @"http://wx4.sinaimg.cn/mw600/0085KTY1gy1ggdszf1e9dj30cs0h10tm.jpg",
        @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdv58xbztj30jg0t60y9.jpg",
        @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdrr9ulh7j30jg0t64fe.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdrlahu23j30u019vass.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1ggdrex90apj30hs0haajt.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdr4fqy6ij316m0u0hdt.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdq7o5303j30jg0t6acu.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdwri1jkgj30oh10m4n5.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdwhfjcncj31900u0wud.jpg",
    @"http://ww1.sinaimg.cn/mw600/9f0b0dd5ly1ggdvmg3xd4j20mj0s6tbo.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdvf7wgwbj30xc0m9tfh.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdv9khjdvj30u018zwl6.jpg"];
    [_messageImageView tt_setImageWithURL:[NSURL URLWithString:temp[arc4random() %( temp.count - 1)]]];
}


- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
//        _messageImageView.image = [UIImage imageNamed:@"messageTypeHint"];
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
        _messageImageView.clipsToBounds = YES;
        _messageImageView.layer.masksToBounds = YES;
        _messageImageView.layer.cornerRadius = CGFloatIn750(45);
    }
    
    return _messageImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"小莫通知";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _detailLabel.text = @"图形俱乐部讽德诵功对方过得舒服个人风格如果太热";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _detailLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor colorTextGray];
        _timeLabel.text = @"10/13";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = [UIColor colorWhite];
        _numLabel.text = @"2";
        _numLabel.backgroundColor = [UIColor colorMain];
        _numLabel.numberOfLines = 1;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.layer.cornerRadius = CGFloatIn750(16);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontMin]];
    }
    return _numLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(170);
}
@end
