//
//  ZMineStudentEvaEditUpdateImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaEditUpdateImageCell.h"
@interface ZMineStudentEvaEditUpdateImageCell ()

@property (nonatomic,strong) UIImageView *cameraImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *hintLabel;

@end

@implementation ZMineStudentEvaEditUpdateImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KWhiteColor;
   
    
    [self.contentView addSubview:self.cameraImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.hintLabel];
    

    
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(35));
        make.width.height.mas_equalTo(CGFloatIn750(90));

    }];

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cameraImageView.mas_right).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.cameraImageView.mas_centerY).offset(CGFloatIn750(-4));
    }];
    
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cameraImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.cameraImageView.mas_centerY).offset(CGFloatIn750(10));
            }];
    
   
}


#pragma mark -Getter
-(UIImageView *)cameraImageView {
    if (!_cameraImageView) {
        _cameraImageView = [[UIImageView alloc] init];
        _cameraImageView.image = [UIImage imageNamed:@"uploadCamera"];
        _cameraImageView.contentMode = UIViewContentModeScaleAspectFill;
        _cameraImageView.clipsToBounds = YES;
        _cameraImageView.backgroundColor = KBackColor;
    }
    
    return _cameraImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KFont3Color;
        _titleLabel.text = @"上传照片";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(28)]];
    }
    return _titleLabel;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = KFont6Color;
        _hintLabel.text = @"添加照片可以让大家更了解喔~";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _hintLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}
@end

