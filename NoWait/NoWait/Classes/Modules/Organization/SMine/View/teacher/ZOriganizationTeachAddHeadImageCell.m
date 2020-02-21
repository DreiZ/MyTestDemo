//
//  ZOriganizationTeachAddHeadImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachAddHeadImageCell.h"

@interface ZOriganizationTeachAddHeadImageCell ()
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation ZOriganizationTeachAddHeadImageCell

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
    
 
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.headImageView];
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.mas_equalTo(CGFloatIn750(104));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImageView.mas_centerX);
        make.top.equalTo(self.headImageView.mas_bottom).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(154));
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [coverBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    }];
    
    [self.contentView addSubview:coverBtn];
    [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top);
        make.bottom.equalTo(self.nameLabel.mas_bottom).offset(-CGFloatIn750(20));
        make.left.equalTo(self.nameLabel.mas_left).offset(-CGFloatIn750(30));
        make.right.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(30));
    }];
}

#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _nameLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
        _nameLabel.text = @"上传头像";
        _nameLabel.numberOfLines = 1;
        ViewRadius(_nameLabel, CGFloatIn750(30));
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"uploadUserHeadImage"];
        _headImageView.backgroundColor = adaptAndDarkColor([UIColor colorGrayContentBG], [UIColor colorGrayContentBGDark]);
        _headImageView.contentMode = UIViewContentModeCenter;
        ViewRadius(_headImageView, CGFloatIn750(52));
    }
    return _headImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(280);
}

@end




