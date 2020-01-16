//
//  ZSingleLineCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSingleLineCell.h"

@interface ZSingleLineCell ()

@end

@implementation ZSingleLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-kCellRightMargin);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_right).offset(kCellLeftMargin);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftImageView.mas_right).offset(kCellContentSpace);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_left).offset(-kCellContentLittleSpace);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(KScreenWidth/3);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}


#pragma mark -Getter
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightImageView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = KFont3Color;
        _leftTitleLabel.text = @"";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = KFont6Color;
        _rightTitleLabel.text = @"";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _rightTitleLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.layer.masksToBounds = YES;
        _bottomLineView.backgroundColor = KLineColor;
    }
    return _bottomLineView;
}

- (void)setModel:(ZBaseSingleCellModel *)model {
    _model = model;
    
    self.leftTitleLabel.text = model.leftTitle;
    self.rightTitleLabel.text = model.rightTitle;
    self.leftTitleLabel.numberOfLines = 1;
    
    self.leftTitleLabel.font = model.leftFont ? model.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
    self.rightTitleLabel.font = model.rightFont ? model.rightFont:[UIFont systemFontOfSize:kCellTitleFont];
    
    self.leftTitleLabel.textColor = model.leftColor ? model.leftColor:KBlackColor;
    self.rightTitleLabel.textColor = model.rightColor ? model.rightColor:KBlackColor;
    self.bottomLineView.hidden = model.isHiddenLine;
    
    
    if (model.leftImage && model.leftImage.length > 0) {
        self.leftImageView.image = [UIImage imageNamed:model.leftImage];
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
        }];
        
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.leftImageView.mas_right).offset(model.leftContentSpace);
        }];
        
        self.leftImageView.hidden = NO;
    }else{
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(-model.leftMargin);
            
        }];
        
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
        }];
        
        self.leftImageView.hidden = YES;
    }
    
    
    if (model.rightImage && model.rightImage.length > 0) {
        self.rightImageView.image = [UIImage imageNamed:model.rightImage];
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
        }];
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(KScreenWidth/3);
        }];
        
        self.rightImageView.hidden = NO;
    }else{
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(model.rightMargin);
        }];
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(KScreenWidth/3);
        }];
        
        self.rightImageView.hidden = YES;
    }
    
    self.bottomLineView.hidden = model.isHiddenLine;
}


+ (CGFloat)z_getCellHeight:(id)sender {
    if ([sender isKindOfClass:[ZBaseCellModel class]]) {
        ZBaseCellModel *cellModel = sender;
        return cellModel.cellHeight;
    }
    return kCellNormalHeight;
}
@end
