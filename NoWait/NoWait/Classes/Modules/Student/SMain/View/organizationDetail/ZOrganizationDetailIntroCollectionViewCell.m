//
//  ZOrganizationDetailIntroCollectionViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailIntroCollectionViewCell.h"

@interface ZOrganizationDetailIntroCollectionViewCell ()
@property (nonatomic,strong) UIView *contBackView;

@end

@implementation ZOrganizationDetailIntroCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contBackView];
    [self.contBackView addSubview:self.detailImageView];
    
    [self.contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contBackView);
    }];
}


#pragma mark -懒加载
- (UIView *)contBackView {
    if (!_contBackView) {
        _contBackView = [[UIView alloc] init];
        _contBackView.layer.masksToBounds = YES;
        _contBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contBackView;
}

- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.layer.masksToBounds = YES;
        _detailImageView.layer.cornerRadius = CGFloatIn750(8);
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detailImageView;
}

@end

