//
//  ZStudentShareQrcodeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentShareQrcodeCell.h"
#import <LBXScanNative.h>

@interface ZStudentShareQrcodeCell ()
@property (nonatomic,strong) UIImageView *shareImageView;
@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UILabel *hintSubLabel;
@end

@implementation ZStudentShareQrcodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.shareImageView];
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
        make.width.height.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.contentView addSubview:self.hintLabel];
    [self.contentView addSubview:self.hintSubLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareImageView.mas_left).offset(-CGFloatIn750(50));
        make.bottom.equalTo(self.shareImageView.mas_centerY).offset(-CGFloatIn750(6));
    }];
    
    [self.hintSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintLabel.mas_left);
        make.top.equalTo(self.shareImageView.mas_centerY).offset(CGFloatIn750(6));
    }];
}

- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] init];
        _shareImageView.layer.masksToBounds = YES;
        ViewRadius(_shareImageView, CGFloatIn750(16));
    }
    return _shareImageView;
}

- (void)setImage:(NSString *)image {
    UIImage *qrImage = [LBXScanNative createQRWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", kStoreAppId] QRSize:CGSizeMake(CGFloatIn750(140), CGFloatIn750(140)) QRColor:[UIColor colorMain] bkColor:[UIColor colorGrayBG]];
    _image = image;
    _shareImageView.image = qrImage;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _hintLabel.text = @"长按或扫描";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont fontSmall]];
    }
    return _hintLabel;
}


- (UILabel *)hintSubLabel {
    if (!_hintSubLabel) {
        _hintSubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintSubLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _hintSubLabel.text = @"查看详情";
        _hintSubLabel.numberOfLines = 1;
        _hintSubLabel.textAlignment = NSTextAlignmentLeft;
        [_hintSubLabel setFont:[UIFont fontSmall]];
    }
    return _hintSubLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}
@end

