//
//  ZNoDataCollectionViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZNoDataCollectionViewCell.h"

@interface ZNoDataCollectionViewCell ()
@property (nonatomic,strong) UIImageView *noDataImageView;
@property (nonatomic,strong) UILabel *noDataLabel;

@end

@implementation ZNoDataCollectionViewCell
- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.noDataImageView];
    [self.contentView addSubview:self.noDataLabel];
    
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-CGFloatIn750(70));
    }];
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(CGFloatIn750(30));
    }];
}


- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] init];
        _noDataImageView.image = isDarkModel()? [UIImage imageNamed:@"emptyDataDark"]:[UIImage imageNamed:@"emptyData"];
        _noDataImageView.layer.masksToBounds = YES;
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        _noDataImageView.layer.cornerRadius = CGFloatIn750(40);
    }
    return _noDataImageView;
}

- (UILabel *)noDataLabel  {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noDataLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1]);
        _noDataLabel.text = @"暂无数据";
        _noDataLabel.numberOfLines = 0;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        [_noDataLabel setFont:[UIFont fontContent]];
    }
    return _noDataLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _noDataLabel.text = title;
}

+ (CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(KScreenWidth, KScreenHeight);
}
@end
