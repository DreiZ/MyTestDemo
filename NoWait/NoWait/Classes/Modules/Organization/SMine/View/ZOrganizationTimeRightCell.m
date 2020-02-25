//
//  ZOrganizationTimeRightCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeRightCell.h"

@interface ZOrganizationTimeRightCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *hintView;

@end

@implementation ZOrganizationTimeRightCell

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
    
    [self.contentView addSubview:self.hintView];
    [self.contentView addSubview:self.nameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(8));
        make.width.mas_equalTo(CGFloatIn750(8));
    }];
}


#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"添加时间段 >";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIImageView *)hintView {
    if (!_hintView) {
        _hintView = [[UIImageView alloc] init];
        _hintView.backgroundColor = [UIColor colorMain];
    }
    return _hintView;
}

- (void)setTitle:(NSString *)title {
    _nameLabel.text = title;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(108);
}

@end

