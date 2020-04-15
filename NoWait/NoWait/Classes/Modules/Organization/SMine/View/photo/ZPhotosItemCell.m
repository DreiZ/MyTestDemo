//
//  ZPhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZPhotosItemCell.h"

@interface ZPhotosItemCell ()
@property (nonatomic,strong) UIView *hintView;
@property (nonatomic,strong) UIImageView *detailImageView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *deleteBigBtn;
@end

@implementation ZPhotosItemCell

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
        make.center.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(222));
        make.height.mas_equalTo(CGFloatIn750(148));
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
    
}


- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
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
        [_deleteBtn setImage:[UIImage imageNamed:@"lessonSelectClose"] forState:UIControlStateNormal];
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
                weakSelf.delBlock();
            }
        }];
    }
    return _deleteBigBtn;
}

- (void)setModel:(ZBaseUnitModel *)model {
    _model = model;
   
    if ([model.data isKindOfClass:[UIImage class]]) {
        self.detailImageView.image = model.data;
    }else if ([model.data isKindOfClass:[NSString class]]){
        NSString *temp = model.data;
        [self.detailImageView tt_setImageWithURL:[NSURL URLWithString:temp] placeholderImage:[UIImage imageNamed:@"default_image"]];
    }
    
    if (model.isEdit) {
        self.deleteBtn.hidden = NO;
        self.deleteBigBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
        self.deleteBigBtn.hidden = YES;
    }
}
@end


