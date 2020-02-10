//
//  ZStudentStarStudentSectionTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarStudentSectionTitleCell.h"

@interface ZStudentStarStudentSectionTitleCell ()
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation ZStudentStarStudentSectionTitleCell
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
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
  
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(36)]];
    }
    return _nameLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}


- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = title;
}
@end

