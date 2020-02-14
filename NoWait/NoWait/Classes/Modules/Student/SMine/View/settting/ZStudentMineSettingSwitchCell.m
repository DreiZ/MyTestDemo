//
//  ZStudentMineSettingSwitchCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingSwitchCell.h"

@interface ZStudentMineSettingSwitchCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UISwitch *iSwitch;

@end

@implementation ZStudentMineSettingSwitchCell

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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
    }];
    
    [self.contentView addSubview:self.iSwitch];
    [self.iSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(60));
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _titleLabel;
}

- (UISwitch *)iSwitch {
    if (!_iSwitch) {
        _iSwitch = [[UISwitch alloc] init];
    }
    return _iSwitch;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}
@end

