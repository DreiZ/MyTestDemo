//
//  ZOrganizationLessonTypeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonTypeCell.h"

@interface ZOrganizationLessonTypeCell ()

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@end

@implementation ZOrganizationLessonTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(0));
       make.centerY.equalTo(self.mas_centerY);
   }];
   
   
   [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.rightTitleLabel.mas_right).offset(CGFloatIn750(10));
       make.centerY.equalTo(self.mas_centerY);
   }];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.leftTitleLabel.mas_left);
        make.right.equalTo(self.leftImageView.mas_right);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.rightTitleLabel.mas_left);
        make.right.equalTo(self.rightImageView.mas_right);
    }];
}


#pragma mark -Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"固定时间开课";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldFontTitle]];
    }
    return _leftTitleLabel;
}


- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _rightTitleLabel.text = @"人满开课";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_rightTitleLabel setFont:[UIFont boldFontTitle]];
    }
    return _rightTitleLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"studentSelect"];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"studentSelect"];
    }
    return _rightImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(112);
}

@end


