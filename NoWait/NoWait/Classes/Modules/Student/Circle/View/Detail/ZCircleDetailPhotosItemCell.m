//
//  ZCircleDetailPhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailPhotosItemCell.h"

@interface ZCircleDetailPhotosItemCell ()
@property (nonatomic,strong) UIView *hintView;
@end

@implementation ZCircleDetailPhotosItemCell

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
    
    [self.contentView addSubview:self.hintView];
    [self.hintView addSubview:self.detailImageView];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hintView);
    }];
    
    [self.detailImageView addSubview:self.playerImageView];
    [self.playerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailImageView.mas_centerX);
        make.centerY.equalTo(self.detailImageView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    self.detailImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.detailImageView addGestureRecognizer:tap];
}

- (void)handleTapGesture:(id)sender {
    if (self.seeBlock) {
        self.seeBlock();
    }
}

- (SJPlayerSuperImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[SJPlayerSuperImageView alloc] init];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _detailImageView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _detailImageView;
}

- (UIImageView *)playerImageView {
    if (!_playerImageView) {
        _playerImageView = [[UIImageView alloc] init];
        _playerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _playerImageView.image = [UIImage imageNamed:@"finderPlayer"];
        _playerImageView.clipsToBounds = YES;
    }
    return _playerImageView;
}

- (UIView *)hintView {
    if (!_hintView) {
        _hintView = [[UIView alloc] init];
        _hintView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_hintView, CGFloatIn750(8));
    }
    return _hintView;
}


- (void)setModel:(ZFileUploadDataModel *)model {
    _model = model;
    if (model.taskType == ZUploadTypeVideo) {
        self.playerImageView.hidden = NO;
    }else{
        self.playerImageView.hidden = YES;
    }
    if (model.image) {
        self.detailImageView.image = model.image;
    }else if(model.image_url){
        if (isVideo(model.image_url)) {
            [self.detailImageView tt_setImageWithURL:[NSURL URLWithString:aliyunVideoFullUrl(model.image_url)]];
        }else{
            [self.detailImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image_url)]];
        }
    }
}

+ (CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(213), CGFloatIn750(214));
}
@end
