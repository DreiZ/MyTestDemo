//
//  ZOrganizationPhotoListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoListCell.h"

@interface ZOrganizationPhotoListCell ()
@property (nonatomic,strong) UILabel *photoLabel;
@property (nonatomic,strong) UIImageView *photoImageView;

@end

@implementation ZOrganizationPhotoListCell


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.photoImageView];
    
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(0));
    }];

    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.photoImageView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.photoImageView);
        make.height.mas_equalTo(CGFloatIn750(70));
    }];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HexAColor(0x000000, 0.01).CGColor, (__bridge id)HexAColor(0x000000, 0.2).CGColor, (__bridge id)HexAColor(0x000000, 0.5).CGColor];
    gradientLayer.locations = @[@0.1, @0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, KScreenWidth - CGFloatIn750(60), CGFloatIn750(70));
    [bottomLineView.layer insertSublayer:gradientLayer atIndex:0];
    
    [self.photoImageView addSubview:self.photoLabel];
    [self.photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.photoImageView);
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
}


- (UILabel *)photoLabel {
    if (!_photoLabel) {
        _photoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _photoLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _photoLabel.numberOfLines = 1;
        _photoLabel.textAlignment = NSTextAlignmentCenter;
//        _photoLabel.backgroundColor = HexAColor(0x000000, 0.3);
        [_photoLabel setFont:[UIFont fontSmall]];
    }
    return _photoLabel;
}

- (UIImageView *)photoImageView  {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_photoImageView, CGFloatIn750(16));
    }
    return _photoImageView;
}
- (void)setImage:(NSString *)image {
    if (isVideo(image)) {

        [[ZVideoPlayerManager sharedInstance] getVideoPreViewImageURL:[NSURL URLWithString:image] placeHolderImage:[UIImage imageNamed:@"default_image32"] placeHolderBlock:^(UIImage * image) {
            self.photoImageView.image = image;
        } complete:^(UIImage *image) {
            self.photoImageView.image = image;
        }];
    }else{
        [_photoImageView tt_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    }
}

- (void)setModel:(ZOriganizationPhotoListModel *)model {
    _model = model;
    [self setImage:imageFullUrl(model.image)];
    _photoLabel.text = model.name;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(230 + 20 + 10);
}
@end
