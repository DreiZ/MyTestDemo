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
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont fontContent]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = [UIColor colorTextGray];
        _rightTitleLabel.text = @"";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel setFont:[UIFont fontContent]];
    }
    return _rightTitleLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.layer.masksToBounds = YES;
        _bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    }
    return _bottomLineView;
}

- (void)setModel:(ZBaseSingleCellModel *)model {
    _model = model;
    self.bottomLineView.hidden = YES;
    self.leftTitleLabel.text = model.leftTitle;
    self.rightTitleLabel.text = model.rightTitle;
    self.leftTitleLabel.numberOfLines = 1;
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(model.lineLeftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-model.lineRightMargin);
    }];
    
    self.leftTitleLabel.font = model.leftFont ? model.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
    self.rightTitleLabel.font = model.rightFont ? model.rightFont:[UIFont systemFontOfSize:kCellTitleFont];
    
    self.leftTitleLabel.textColor = model.leftColor ? adaptAndDarkColor(model.leftColor,model.leftDarkColor):adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.rightTitleLabel.textColor = model.rightColor ? adaptAndDarkColor(model.rightColor,model.rightDarkColor) :adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.bottomLineView.backgroundColor = adaptAndDarkColor(model.lineColor, model.lineDarkColor);
    
    self.bottomLineView.hidden = model.isHiddenLine;
    
    
    if (model.leftImage && model.leftImage.length > 0) {
        if (![model.leftImage tt_isValidUrl]) {
            self.leftImageView.image = [UIImage imageNamed:model.leftImage];
            [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            }];
        }else{
            [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:model.leftImage]];
            [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                make.height.width.mas_equalTo(model.cellHeight > 0.001 ? model.cellHeight - CGFloatIn750(10) : kCellNormalHeight - CGFloatIn750(10));
            }];
        }
        
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.leftImageView.mas_right).offset(model.leftContentSpace);
        }];
        
        self.leftImageView.hidden = NO;
    }else{
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(-model.leftMargin);
            make.width.height.mas_equalTo(1);
        }];
        
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
        }];
        
        self.leftImageView.hidden = YES;
    }
    
    
    if (model.rightImage && model.rightImage.length > 0) {
        if (![model.rightImage tt_isValidUrl]) {
            self.rightImageView.image = [UIImage imageNamed:model.rightImage];
            [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            }];
        }else{
            [self.rightImageView tt_setImageWithURL:[NSURL URLWithString:model.rightImage]];
            [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                make.height.width.mas_equalTo(model.cellHeight > 0.001 ? model.cellHeight - CGFloatIn750(10) : kCellNormalHeight - CGFloatIn750(10));
            }];
        }
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.width.mas_equalTo(KScreenWidth/3);
        }];
        
        self.rightImageView.hidden = NO;
    }else{
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(model.rightMargin);
            make.width.height.mas_equalTo(1);
        }];
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.width.mas_equalTo(KScreenWidth/3);
        }];
        
        self.rightImageView.hidden = YES;
    }
    
    if (_model.rightImage && [_model.rightImage isEqualToString:@"rightBlackArrowN"]) {
        self.rightImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
    }
    
    if ([_model.leftImage isEqualToString:@"peoples_hint"] ||
        [_model.leftImage isEqualToString:@"erweimlist"] ||
        [_model.leftImage isEqualToString:@"listadd"] ) {
        self.leftImageView.image = [[UIImage imageNamed:model.leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.leftImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }else if(ValidStr(model.leftImage)){
        if (![model.leftImage tt_isValidUrl]) {
            self.leftImageView.image = [[UIImage imageNamed:model.leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:model.leftImage]];
        }
        self.leftImageView.tintColor = nil;
    }
}


+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZBaseCellModel class]]) {
        ZBaseCellModel *cellModel = sender;
        if (cellModel.cellHeight > 0.1) {
            return cellModel.cellHeight;
        }
        return kCellNormalHeight;
    }
    return kCellNormalHeight;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if (self.model.rightImage && [self.model.rightImage isEqualToString:@"rightBlackArrowN"]) {
        self.rightImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
    }
}
@end
