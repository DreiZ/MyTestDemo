//
//  ZStudentStudentInfoDesCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStudentInfoDesCell.h"

@interface ZStudentStudentInfoDesCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *coachLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@end

@implementation ZStudentStudentInfoDesCell
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
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.coachLabel];
    [self.contentView addSubview:self.lessonLabel];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(280));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top).offset(CGFloatIn750(50));
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
    }];
    
    
    UILabel *nameHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
    nameHintLabel.text = @"教练";
    nameHintLabel.numberOfLines = 1;
    nameHintLabel.textAlignment = NSTextAlignmentLeft;
    [nameHintLabel setFont:[UIFont fontContent]];
    [self addSubview:nameHintLabel];
    
    UILabel *lessonHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lessonHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
    lessonHintLabel.text = @"课程";
    lessonHintLabel.numberOfLines = 1;
    lessonHintLabel.textAlignment = NSTextAlignmentLeft;
    [lessonHintLabel setFont:[UIFont fontContent]];
    [self addSubview:lessonHintLabel];
    
    [nameHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(40));
    }];
    
    [lessonHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(nameHintLabel.mas_bottom).offset(CGFloatIn750(30));
    }];
    
    [self.coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameHintLabel.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(nameHintLabel.mas_centerY);
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameHintLabel.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(lessonHintLabel.mas_centerY);
    }];
    
    
   [ _userImageView tt_setImageWithURL:[NSURL URLWithString:@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gd18u2misdj30u011in1f.jpg"]];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"齐丽旺";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UILabel *)coachLabel {
    if (!_coachLabel) {
        _coachLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _coachLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _coachLabel.text = @"段世昌";
        _coachLabel.numberOfLines = 1;
        _coachLabel.textAlignment = NSTextAlignmentLeft;
        [_coachLabel setFont:[UIFont fontContent]];
    }
    return _coachLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonLabel.text = @"瑜伽培训班";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontContent]];
    }
    return _lessonLabel;
}
- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        ViewRadius(_userImageView, CGFloatIn750(16));
    }
    return _userImageView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(368);
}

@end



