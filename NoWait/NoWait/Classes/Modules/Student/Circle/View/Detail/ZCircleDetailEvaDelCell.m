//
//  ZCircleDetailEvaDelCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailEvaDelCell.h"

@interface ZCircleDetailEvaDelCell ()
@property (nonatomic,strong) UILabel *delLabel;

@end

@implementation ZCircleDetailEvaDelCell

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.delLabel];
    [self.delLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [delBtn bk_whenTapped:^{
        if (weakSelf.delBlock) {
            weakSelf.delBlock();
        }
    }];
    [self.contentView addSubview:delBtn];
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.delLabel.mas_left).offset(-CGFloatIn750(30));
        make.top.bottom.right.equalTo(self.contentView);
    }];
}

- (UILabel *)delLabel {
    if (!_delLabel) {
        _delLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _delLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _delLabel.text = @"删除";
        _delLabel.numberOfLines = 0;
        _delLabel.textAlignment = NSTextAlignmentLeft;
        [_delLabel setFont:[UIFont fontMin]];
    }
    return _delLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(40);
}
@end
