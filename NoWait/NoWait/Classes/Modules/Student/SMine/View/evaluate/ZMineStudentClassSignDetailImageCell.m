//
//  ZMineStudentClassSignDetailImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentClassSignDetailImageCell.h"

@interface ZMineStudentClassSignDetailImageCell ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *cImageView;

@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation ZMineStudentClassSignDetailImageCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];

    [self.contView addSubview:self.titleLabel];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.contView addSubview:self.cImageView];
    [self.cImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    [self.contView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-20));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(20));
    }];
}

#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_contView, CGFloatIn750(0));
    }
    return _contView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontSmall]];
    }
    return _titleLabel;
}

- (UIImageView *)cImageView {
    if (!_cImageView) {
        _cImageView = [[UIImageView alloc] init];
        _cImageView.layer.masksToBounds = YES;
        _cImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _cImageView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(244);
}

- (void)setImage:(NSString *)image{
    _image = image;
    
    [_cImageView tt_setImageWithURL:[NSURL URLWithString:image]];
}
@end






