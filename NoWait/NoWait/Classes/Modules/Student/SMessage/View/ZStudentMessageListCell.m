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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.messageImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.numLabel];
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(76));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-28));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(28));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(18));
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageImageView.mas_right).offset(CGFloatIn750(22));
        make.top.equalTo(self.messageImageView.mas_top).offset(CGFloatIn750(4));
        make.right.equalTo(self.timeLabel.mas_left).offset(-CGFloatIn750(10));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(8));
        make.right.equalTo(self.titleLabel.mas_right);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorBlackBG]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.image = [UIImage imageNamed:@"messageTypeHint"];
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
        _messageImageView.clipsToBounds = YES;
        _messageImageView.layer.masksToBounds = YES;
        _messageImageView.layer.cornerRadius = CGFloatIn750(20);
    }
    
    return _messageImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
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
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
        _detailLabel.text = @"图形俱乐部讽德诵功对方过得舒服个人风格如果太热";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
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
        _numLabel.backgroundColor = [UIColor colorRedDefault];
        _numLabel.numberOfLines = 1;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.layer.cornerRadius = CGFloatIn750(13);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontMin]];
    }
    return _numLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(116);
}
@end
