//
//  ZCircleDetailSchoolCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailSchoolCell.h"
#import "CWStarRateView.h"

@interface ZCircleDetailSchoolCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *organizationImageView;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIButton *openBtn;
@property (nonatomic,strong) UIImageView *collectionImageView;
@property (nonatomic,strong) CWStarRateView *crView;

@end

@implementation ZCircleDetailSchoolCell

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.organizationImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.openBtn];
    [self.contentView addSubview:self.lessonLabel];
    [self.contentView addSubview:self.crView];
    
    [self.organizationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(120));
        make.height.mas_equalTo(CGFloatIn750(74));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizationImageView.mas_top);
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(12));
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.width.offset(CGFloatIn750(100));
        make.centerY.equalTo(self.lessonLabel.mas_centerY);
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(6));
        make.left.equalTo(self.crView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
    
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_whenTapped:^{
        if (self.handleBlock) {
            self.handleBlock(0);
        }
    }];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.openBtn.mas_left);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(0.5);
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

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontSmall]];
    }
    return _lessonLabel;
}

- (UIImageView *)organizationImageView {
    if (!_organizationImageView) {
        _organizationImageView = [[UIImageView alloc] init];
        _organizationImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_organizationImageView, CGFloatIn750(16));
    }
    return _organizationImageView;
}


- (UIImageView *)collectionImageView {
    if (!_collectionImageView) {
        _collectionImageView = [[UIImageView alloc] init];
        _collectionImageView.contentMode = UIViewContentModeScaleAspectFill;
        _collectionImageView.image = [UIImage imageNamed:@"handleStore"];
    }
    return _collectionImageView;
}


-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        _openBtn.imageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
//        _openBtn.imageView.image = [[UIImage imageNamed:@"handleStore"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_openBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_openBtn addSubview:self.collectionImageView];
        [self.collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.openBtn);
            make.width.height.mas_equalTo(CGFloatIn750(32));
        }];
    }
    return _openBtn;
}

- (void)setModel:(ZCircleDynamicInfo *)model {
    
    _lessonLabel.text = model.store_distance;
    _nameLabel.text = model.store_name;

    [ _organizationImageView tt_setImageWithURL:[NSURL URLWithString:model.store_image] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    
    _crView.scorePercent = [model.score floatValue]/5;
    
    if ([model.store_collection intValue] > 0) {
        _collectionImageView.image = [UIImage imageNamed:@"collectionHandle"];
    }else{
        _collectionImageView.image = [UIImage imageNamed:@"handleStore"];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

@end
