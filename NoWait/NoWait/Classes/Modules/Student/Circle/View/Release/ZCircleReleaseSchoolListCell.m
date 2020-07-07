//
//  ZCircleReleaseSchoolListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseSchoolListCell.h"

@interface ZCircleReleaseSchoolListCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UIImageView *schoolImageView;

@end


@implementation ZCircleReleaseSchoolListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.schoolImageView];
    [self.schoolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.schoolImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.schoolImageView.mas_top).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView
                           .mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.contentView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.schoolImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView
                           .mas_right).offset(-CGFloatIn750(30));
    }];
    
    [_schoolImageView tt_setImageWithURL:[NSURL URLWithString:@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggi3cu0t9dj31900u0n51.jpg"]];
    _nameLabel.text = @"打发斯蒂芬";
    _distanceLabel.text = @"123M";
}


#pragma mark -Getter
- (UIImageView *)schoolImageView {
    if (!_schoolImageView) {
        _schoolImageView = [[UIImageView alloc] init];
        _schoolImageView.layer.masksToBounds = YES;
        _schoolImageView.layer.cornerRadius = CGFloatIn750(10);
        _schoolImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _schoolImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _distanceLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _distanceLabel.numberOfLines = 1;
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        [_distanceLabel setFont:[UIFont fontSmall]];
    }
    return _distanceLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(164);
}
@end

