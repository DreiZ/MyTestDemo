//
//  ZStudentCoachInfoTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentCoachInfoTitleCell.h"

@interface ZStudentCoachInfoTitleCell ()
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation ZStudentCoachInfoTitleCell
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
   
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = title;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(60);
}

@end




