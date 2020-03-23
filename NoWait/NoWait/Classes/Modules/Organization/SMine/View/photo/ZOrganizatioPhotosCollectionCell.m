//
//  ZOrganizatioPhotosCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizatioPhotosCollectionCell.h"

@interface ZOrganizatioPhotosCollectionCell ()
@property (nonatomic,strong) UIView *hintView;
@property (nonatomic,strong) UIImageView *detailImageView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *deleteBigBtn;
@end

@implementation ZOrganizatioPhotosCollectionCell

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
    [self.hintView addSubview:self.deleteBtn];
    [self.hintView addSubview:self.deleteBigBtn];
    
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hintView);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.hintView);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.deleteBigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.hintView);
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    self.detailImageView.hidden = YES;
}


- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detailImageView;
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
        _deleteBtn.backgroundColor = [UIColor blackColor];
        [_deleteBtn setTitle:@"x" forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont fontMin]];
        ViewRadius(_deleteBtn, CGFloatIn750(8));
    }
    return _deleteBtn;
}

- (UIButton *)deleteBigBtn {
    if (!_deleteBigBtn) {
        __weak typeof(self) weakSelf = self;
        _deleteBigBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBigBtn bk_whenTapped:^{
            if (weakSelf.delBlock) {
                weakSelf.delBlock(weakSelf.model);
            }
        }];
    }
    return _deleteBigBtn;
}

- (void)setModel:(ZOriganizationPhotoTypeListModel *)model {
    _model = model;
    self.deleteBtn.hidden = NO;
    self.deleteBigBtn.hidden = NO;
    self.detailImageView.hidden = NO;
    
//    if (model.isSelected) {
//        self.deleteBtn.hidden = NO;
//        self.deleteBigBtn.hidden = NO;
//    }else{
//        self.deleteBtn.hidden = YES;
//        self.deleteBigBtn.hidden = YES;
//    }
    
    if ([model.images_url isKindOfClass:[NSString class]]){
        NSString *temp = model.images_url;
        if (temp.length > 0) {
            [self.detailImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(temp)]];
        }else{
            self.detailImageView.hidden = YES;
        }
    }
}
@end


