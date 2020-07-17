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
@property (nonatomic,strong) UIImageView *playImageView;

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
    [self.contBackView addSubview:self.playImageView];
    self.playImageView.hidden = YES;
    
    [self.contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contBackView);
    }];
    
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contBackView);
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

- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] init];
        _playImageView.layer.masksToBounds = YES;
        _playImageView.image = [UIImage imageNamed:@"infomationVideoPlay"];
        _playImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _playImageView;
}

- (void)setImage:(NSString *)image {
    _image = image;
    
    if (isVideo(image)) {
        [_detailImageView tt_setImageWithURL:[NSURL URLWithString:aliyunVideoFullUrl(image)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
        
        self.playImageView.hidden = NO;
    }else{
        [_detailImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(image)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
        self.playImageView.hidden = YES;
    }
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth-CGFloatIn750(90))/2, (KScreenWidth-CGFloatIn750(90))/2 * (110.0f/165));
}
@end

