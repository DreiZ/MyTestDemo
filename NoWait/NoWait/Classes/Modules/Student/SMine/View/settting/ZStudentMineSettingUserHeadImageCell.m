//
//  ZStudentMineSettingUserHeadImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingUserHeadImageCell.h"
#import "TZImageCropManager.h"

@interface ZStudentMineSettingUserHeadImageCell ()
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIView *bottomLineView;

@property (nonatomic,strong) NSDictionary *data;
@end

@implementation ZStudentMineSettingUserHeadImageCell

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
    
    [self.contentView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-CGFloatIn750(10));
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_right).offset(CGFloatIn750(30));
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_left).offset(CGFloatIn750(-10));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(272));
    }];
    
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}



#pragma mark -Getter
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"rightBlackArrowN"];
        _arrowImageView.layer.masksToBounds = YES;
    }
    return _arrowImageView;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.layer.cornerRadius = CGFloatIn750(40);
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
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
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

- (void)setModel:(ZLineCellModel *)model {
    _model = model;
    _leftTitleLabel.text = model.leftTitle;
    _rightTitleLabel.text = model.rightTitle;
    
    _leftTitleLabel.font = model.leftFont ? model.leftFont:[UIFont boldFontMaxTitle];
    _rightTitleLabel.font = model.rightFont ? model.rightFont:[UIFont boldFontMaxTitle];
    self.leftTitleLabel.textColor = model.leftColor ? adaptAndDarkColor(model.leftColor,model.leftDarkColor):adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.rightTitleLabel.textColor = model.rightColor ? adaptAndDarkColor(model.rightColor,model.rightDarkColor) :adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.bottomLineView.backgroundColor = model.lineColor;

    self.bottomLineView.hidden = model.isHiddenLine;
    self.bottomLineView.backgroundColor = adaptAndDarkColor(model.lineColor, model.lineDarkColor);
    
    if (model.leftImage) {
        self.leftImageView.image = [UIImage imageNamed:model.leftImage];
        
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        }];
        
        self.leftImageView.hidden = NO;
    }else{
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(10));
        }];
        
        self.leftImageView.hidden = YES;
    }
    
    if (model.data) {
        if (model.data && [model.data isKindOfClass:[NSString class]] && ((NSString *)model.data).length > 0) {
//            [self.rightImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.data)] placeholderImage:[UIImage imageNamed:@"default_head"]];
         
            if (ValidStr(model.data)) {
                [LKUIUtils downloadShareImage:SafeStr(model.data) complete:^(UIImage *image) {
                    if (!image) {
                        image = [UIImage imageNamed:@"default_head"];
                    }
                    image = [TZImageCropManager circularClipImage:image];
                    [LKUIUtils doubleAnimaitonWithImageView:self.rightImageView toImage:image duration:0.8 animations:^{
                        
                    } completion:^{
                        
                    }];
                }];
            }
            
            self.rightImageView.hidden = NO;
        }else if (model.data && [model.data isKindOfClass:[UIImage class]] ){
            self.rightImageView.image = model.data;
            
            self.rightImageView.hidden = NO;
        }else{
            self.rightImageView.image = [UIImage imageNamed:@"default_head"];
        }
    }else{
        self.rightImageView.image = [UIImage imageNamed:@"default_head"];
    }
    
//    if (model.rightImage && model.rightImage.length > 0) {
//        self.rightImageView.image = [UIImage imageNamed:model.rightImage];
//        
//        self.rightImageView.hidden = NO;
//    }else{
//        
//        self.rightImageView.hidden = YES;
//    }
}

- (void)setBottomLineHidden:(BOOL)isHidden {
    self.bottomLineView.hidden = isHidden;
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
//    _arrowImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] : [UIImage imageNamed:@"rightBlackArrowN"];
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}
@end




