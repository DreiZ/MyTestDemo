//
//  ZCirclePhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCirclePhotosItemCell.h"

@interface ZCirclePhotosItemCell ()
@property (nonatomic,strong) UIView *hintView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *deleteBigBtn;
@end

@implementation ZCirclePhotosItemCell

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
    
    __weak typeof(self) weakSelf = self;
    UIButton *seeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [seeBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.seeBlock) {
            weakSelf.seeBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.hintView addSubview:seeBtn];
    
    [self.hintView addSubview:self.deleteBtn];
    [self.hintView addSubview:self.deleteBigBtn];
    
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hintView);
    }];
    
    [seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailImageView);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.hintView);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.deleteBigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.hintView);
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.contentView addSubview:self.playerImageView];
    [self.playerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailImageView.mas_centerX);
        make.centerY.equalTo(self.detailImageView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
}


- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
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

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _deleteBtn.backgroundColor = [UIColor colorBlackBGDark];
        [_deleteBtn setImage:[UIImage imageNamed:@"LoginClose"] forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont fontMin]];
        ViewRadius(_deleteBtn, CGFloatIn750(8));
    }
    return _deleteBtn;
}

- (UIButton *)deleteBigBtn {
    if (!_deleteBigBtn) {
        __weak typeof(self) weakSelf = self;
        _deleteBigBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBigBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.delBlock) {
                weakSelf.delBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBigBtn;
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

- (void)setIsEdit:(BOOL)isEdit {
    if (isEdit) {
        self.deleteBtn.hidden = NO;
        self.deleteBigBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
        self.deleteBigBtn.hidden = YES;
    }
}

+ (CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(213), CGFloatIn750(214));
}
@end
