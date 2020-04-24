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
    [super setupView];
    
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
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = @"消息推送";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

- (UISwitch *)iSwitch {
    if (!_iSwitch) {
        _iSwitch = [[UISwitch alloc] init];
        [_iSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _iSwitch;
}

- (void)setIsOpen:(NSString *)isOpen {
    _isOpen = isOpen;
    if ([isOpen intValue] == 1) {
        self.iSwitch.on = YES;
    }else{
        self.iSwitch.on = NO;
    }
}

- (void)valueChanged:(UISwitch *)sender {
    if (sender.isOn) {
        if (self.handleBlock) {
            self.handleBlock(@"1");
        }
    }else{
        if (self.handleBlock) {
            self.handleBlock(@"2");
        }
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}
@end

