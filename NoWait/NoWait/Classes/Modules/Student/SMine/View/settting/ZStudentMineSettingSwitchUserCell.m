//
//  ZStudentMineSettingSwitchUserCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingSwitchUserCell.h"
#import "ZUser.h"
#import "ZLoginModel.h"

@interface ZStudentMineSettingSwitchUserCell ()
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;

@end

@implementation ZStudentMineSettingSwitchUserCell

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectZero];
    typeView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [self.contentView addSubview:typeView];
    
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(120));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(50));
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-CGFloatIn750(4));
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_left).offset(CGFloatIn750(18));
        make.top.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(10));
    }];
    
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(24));
        make.centerY.equalTo(self.rightTitleLabel.mas_centerY);
        make.left.equalTo(self.rightTitleLabel.mas_left).offset(CGFloatIn750(-8));
        make.right.equalTo(self.rightTitleLabel.mas_right).offset(CGFloatIn750(8));
    }];
    ViewRadius(typeView, CGFloatIn750(12));
}



#pragma mark - Getter
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.image = [UIImage imageNamed:@"selectedCycle"];
        
    }
    return _rightImageView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(60));
    }
    return _leftImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"机构端";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldFontMax1Title]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _rightTitleLabel.text = @"";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightTitleLabel setFont:[UIFont fontMin]];
    }
    return _rightTitleLabel;
}


- (void)setModel:(ZBaseSingleCellModel *)model {
    _model = model;
    ZUserRolesListModel  *user = model.data;
    NSString *typestr = @"";
//    1：学员 2：教师 6：校区 8：机构
    if ([user.type intValue] == 1) {
        typestr = @"学员端";
    }else if ([user.type intValue] == 2) {
        typestr = @"教师端";
    }else if ([user.type intValue] == 6) {
        typestr = @"校区端";
    }else if ([user.type intValue] == 8) {
        typestr = @"机构端";
    }
    _leftTitleLabel.text = ValidStr(user.nick_name)? SafeStr(user.nick_name): user.phone;
    _rightTitleLabel.text = typestr;
    _rightImageView.hidden = !model.isSelected;
//    _rightTitleLabel.text = user.type;
    [_leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(user.image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(170);
}
@end





