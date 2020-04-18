//
//  ZTeacherMineSignListDetailListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineSignListDetailListItemCell.h"

@interface ZTeacherMineSignListDetailListItemCell ()
@property (nonatomic,strong) UIView *contView;

@end

@implementation ZTeacherMineSignListDetailListItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contView];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(CGFloatIn750(16));
        make.left.equalTo(self.contentView.mas_left).offset(4);
        make.right.equalTo(self.contentView.mas_right).offset(-4);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-CGFloatIn750(12));
    }];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imageView.mas_top).offset(CGFloatIn750(-18));
        make.width.mas_equalTo(CGFloatIn750(100));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = CGFloatIn750(30);
    }
    return _imageView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontMin]];
    }
    return _nameLabel;
}


- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(24);
        ViewBorderRadius(_contView, CGFloatIn750(24), 1, [UIColor colorMainSub]);
    }
    return _contView;
}

- (void)setModel:(ZOriganizationSignListStudentModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    [_imageView tt_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"default_head"]];
    
    if (model.isEdit) {
        if (model.isSelected) {
            _contView.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
            ViewBorderRadius(_contView, CGFloatIn750(24), 1, [UIColor colorMain]);
        }else{
            _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
            ViewBorderRadius(_contView, CGFloatIn750(24), 1, [UIColor colorMain]);
        }
    }else{
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewBorderRadius(_contView, CGFloatIn750(24), 1, adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]));
    }
}
@end
