//
//  ZBaseLineCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseLineCell.h"
#import <UIImage+YYAdd.h>

@interface ZBaseLineCell ()

@end

@implementation ZBaseLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.leftSubTitleLabel];
    [self.contentView addSubview:self.rightSubTitleLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    [self.leftSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    [self.rightSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
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
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
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
        _leftTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont fontContent]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel setFont:[UIFont fontContent]];
    }
    return _rightTitleLabel;
}


- (UILabel *)leftSubTitleLabel {
    if (!_leftSubTitleLabel) {
        _leftSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftSubTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _leftSubTitleLabel.numberOfLines = 1;
        _leftSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftSubTitleLabel setFont:[UIFont fontContent]];
    }
    return _leftSubTitleLabel;
}

- (UILabel *)rightSubTitleLabel {
    if (!_rightSubTitleLabel) {
        _rightSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightSubTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _rightSubTitleLabel.numberOfLines = 1;
        _rightSubTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightSubTitleLabel setFont:[UIFont fontContent]];
    }
    return _rightSubTitleLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.layer.masksToBounds = YES;
        _bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    }
    return _bottomLineView;
}

- (void)layoutSubviews {
//    NSLog(@"layout rightLabel.x %f  %f",self.rightTitleLabel.left,self.rightTitleLabel.width);
}

#pragma mark - set model
- (void)setModel:(ZLineCellModel *)model {
    _model = model;
    
    self.leftTitleLabel.hidden = YES;
    self.leftImageView.hidden = YES;
    self.leftSubTitleLabel.hidden = YES;
    
    self.rightImageView.hidden = YES;
    self.rightTitleLabel.hidden = YES;
    self.rightSubTitleLabel.hidden = YES;
    
    self.bottomLineView.hidden = YES;
    
    UIView *leftTempView = nil;
    UIView *rightTempView = nil;
    
    if (model.isLeftMultiLine) {
        rightTempView = [self setRightViewWith:nil];
        leftTempView = [self setLeftViewWith:rightTempView];
    }else if(model.isRightMultiLine){
        leftTempView = [self setLeftViewWith:nil];
        rightTempView = [self setRightViewWith:leftTempView];
    }else{
        leftTempView = [self setLeftViewWith:nil];
        rightTempView = [self setRightViewWith:leftTempView];
    }
    
    self.bottomLineView.hidden = model.isHiddenLine;
    if (!model.isHiddenLine) {
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(model.lineLeftMargin);
            make.right.equalTo(self.contentView.mas_right).offset(model.lineRightMargin);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
    }else{
        self.bottomLineView.hidden = YES;
    }
}

- (UIView *)setLeftViewWith:(UIView *)rightTempView {
    UIView *leftTempView = nil;
    if (self.model.leftImage) {
        self.leftImageView.hidden = NO;
        
        if (self.model.isLeftImageRadius) {
            self.leftImageView.layer.masksToBounds = YES;
            self.leftImageView.layer.cornerRadius = self.model.leftImageH/2.0f;
        }else{
            self.leftImageView.layer.masksToBounds = NO;
            self.leftImageView.layer.cornerRadius = 0.0f;
        }
        
        
        if ([self.model.leftImage isKindOfClass:[UIImage class]]) {
            self.leftImageView.image = self.model.leftImage;
        }else if ([self.model.leftImage tt_isValidUrl]) {
            [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:self.model.leftImage]];
        }else{
            self.leftImageView.image = [UIImage imageNamed:self.model.leftImage];
        }
        
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
            
            if (self.model.leftImageH > 0.01f) {
                make.width.height.mas_equalTo(self.model.leftImageH);
            }else{
                make.width.mas_equalTo(CGFloatIn750(0));
            }
            
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.centerY.equalTo(self.contentView.mas_top).offset(self.model.cellHeight/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
        }];
        
        leftTempView = self.leftImageView;
    }
    
    if(ValidStr(self.model.leftTitle)){
        self.leftTitleLabel.hidden = NO;
        self.leftTitleLabel.text = self.model.leftTitle;
        self.leftTitleLabel.font = self.model.leftFont;
        self.leftTitleLabel.textAlignment = self.model.leftTextAlignment;
        self.leftTitleLabel.textColor = adaptAndDarkColor(self.model.leftColor, self.model.leftDarkColor);
        self.leftTitleLabel.numberOfLines = self.model.isLeftMultiLine ? 0:1;
        if (self.model.isLeftMultiLine) {
            [ZPublicTool setLineSpacing:self.model.lineSpace label:self.leftTitleLabel];
        }
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.top.equalTo(self.contentView.mas_top).offset((self.model.cellHeight - self.model.leftFont.lineHeight)/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
            
            if (leftTempView) {
                make.left.equalTo(leftTempView.mas_right).offset(self.model.leftContentSpace);
            }else{
                make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
            }
            
            if(self.model.isLeftMultiLine){
                if (ValidStr(self.model.leftSubTitle)) {
                    CGSize leftSubTitleSize = [self.model.leftSubTitle tt_sizeWithFont:self.model.leftSubFont];
                    if (rightTempView) {
                        make.right.equalTo(rightTempView.mas_left).offset(-self.model.leftContentSpace - (leftSubTitleSize.width + 2) - self.model.leftContentSpace);
                    }else{
                        make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin - (leftSubTitleSize.width + 2) - self.model.leftContentSpace);
                    }
                }else{
                    if (rightTempView) {
                        make.right.equalTo(rightTempView.mas_left).offset(-self.model.leftContentSpace);
                    }else{
                        make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
                    }
                }
            }else {
                CGSize leftTitleSize = [self.model.leftTitle tt_sizeWithFont:self.model.leftFont];
                make.width.mas_equalTo(leftTitleSize.width + 2);
            }
        }];
        
        leftTempView = self.leftTitleLabel;
    }
    
    if(ValidStr(self.model.leftSubTitle)){
        self.leftSubTitleLabel.hidden = NO;
        self.leftSubTitleLabel.text = self.model.leftSubTitle;
        self.leftSubTitleLabel.font = self.model.leftSubFont;
        self.leftSubTitleLabel.textColor = adaptAndDarkColor(self.model.leftSubColor, self.model.leftSubDarkColor);
        
        CGSize leftSubTitleSize = [self.model.leftSubTitle tt_sizeWithFont:self.model.leftSubFont];
        
        [self.leftSubTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.top.equalTo(self.contentView.mas_top).offset((self.model.cellHeight - self.model.leftSubFont.lineHeight)/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
            
            if (leftTempView) {
                make.left.equalTo(leftTempView.mas_right).offset(self.model.leftContentSpace);
            }else{
                make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
            }
            make.width.mas_equalTo(leftSubTitleSize.width + 2);
        }];
        
        leftTempView = self.leftSubTitleLabel;
    }
    return leftTempView;
}

- (UIView *)setRightViewWith:(UIView *)leftTempView {
    UIView *rightTempView = nil;
    if (self.model.rightImage) {
        self.rightImageView.hidden = NO;
        if ([self.model.rightImage isKindOfClass:[UIImage class]]) {
            self.rightImageView.image = self.model.rightImage;
        }else if ([self.model.rightImage tt_isValidUrl]) {
            [self.rightImageView tt_setImageWithURL:[NSURL URLWithString:self.model.rightImage]];
        }else{
            self.rightImageView.image = [UIImage imageNamed:self.model.rightImage];
        }
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            if (self.model.rightImageH > 0.01f) {
                make.width.height.mas_equalTo(self.model.rightImageH);
            }else{
                make.width.mas_equalTo(CGFloatIn750(0));
            }
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.centerY.equalTo(self.contentView.mas_top).offset(self.model.cellHeight/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
        }];
        
        rightTempView = self.rightImageView;
    }
    
    if(ValidStr(self.model.rightSubTitle)){
        self.rightSubTitleLabel.hidden = NO;
        self.rightSubTitleLabel.text = self.model.rightSubTitle;
        self.rightSubTitleLabel.font = self.model.rightSubFont;
        self.rightSubTitleLabel.textColor = adaptAndDarkColor(self.model.rightSubColor, self.model.rightSubDarkColor);
        
        CGSize rightSubTitleSize = [self.model.rightSubTitle tt_sizeWithFont:self.model.rightSubFont];
        
        [self.rightSubTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.model.isLeftMultiLine && self.model.isRightMultiLine) {
                make.top.mas_equalTo(self.contentView.mas_top).offset((self.model.cellHeight - self.model.rightSubFont.lineHeight)/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
            
            if (rightTempView) {
                make.right.equalTo(rightTempView.mas_left).offset(-self.model.rightContentSpace);
            }else{
                make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            }
            
            make.width.mas_equalTo(rightSubTitleSize.width + 2);
        }];
        
        rightTempView = self.rightSubTitleLabel;
    }
    
    if(ValidStr(self.model.rightTitle)){
        self.rightTitleLabel.hidden = NO;
        self.rightTitleLabel.text = self.model.rightTitle;
        self.rightTitleLabel.font = self.model.rightFont;
        
        self.rightTitleLabel.textColor = adaptAndDarkColor(self.model.rightColor, self.model.rightDarkColor);

        self.rightTitleLabel.numberOfLines = self.model.isRightMultiLine ? 0:1;
        if (self.model.isRightMultiLine) {
            [ZPublicTool setLineSpacing:self.model.lineSpace label:self.rightTitleLabel];
        }
        self.rightTitleLabel.textAlignment = self.model.rightTextAlignment;
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.top.equalTo(self.contentView.mas_top).offset((self.model.cellHeight - self.model.rightFont.lineHeight)/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
            
            if (rightTempView) {
                make.right.equalTo(rightTempView.mas_left).offset(-self.model.rightContentSpace);
            }else{
                make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            }
            
            if (self.model.isRightMultiLine) {
                if (leftTempView) {
                    if (self.model.leftContentWidth > 0) {
                        make.left.equalTo(self.contentView.mas_left).offset(self.model.leftContentWidth);
                    }else{
                        make.left.equalTo(leftTempView.mas_right).offset(self.model.leftContentSpace);
                    }
                }else{
                    make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
                }
            }else if(self.model.isLeftMultiLine){
                CGSize rightTitleSize = [self.model.rightTitle tt_sizeWithFont:self.model.rightFont];
                make.width.mas_equalTo(rightTitleSize.width + 2);
            }else{
                if (leftTempView) {
                    make.left.equalTo(leftTempView.mas_right).offset(self.model.leftContentSpace);
                }else{
                    make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
                }
            }
        }];
        
        rightTempView = self.rightTitleLabel;
    }
    return rightTempView;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZLineCellModel class]]) {
        ZLineCellModel *model = sender;
        if (model.isLeftMultiLine || model.isRightMultiLine) {
            return [ZBaseLineCell getViewHeight:model];
        }else{
            return model.cellHeight;
        }
    }
    
    return 0.01;
}



+ (CGFloat)getViewHeight:(ZLineCellModel *)model {
    CGFloat cellHeight = 0;
    
    if (model.isLeftMultiLine && ValidStr(model.leftTitle)) {
        CGFloat maxWidth = model.cellWidth - model.leftMargin - model.rightMargin;
        if (model.rightImage) {
            maxWidth = maxWidth - model.rightImageH - model.rightContentSpace;
        }
        
        if (ValidStr(model.rightSubTitle)) {
            CGSize rightSubTitleSize = [model.rightSubTitle tt_sizeWithFont:model.rightSubFont];
            maxWidth = maxWidth - rightSubTitleSize.width - 2 - model.rightContentSpace;
        }
        
        if (ValidStr(model.rightTitle)) {
            CGSize rightTitleSize = [model.rightTitle tt_sizeWithFont:model.rightFont];
            maxWidth = maxWidth - rightTitleSize.width - 2 - model.rightContentSpace;
        }
        
        if (model.leftImage) {
            maxWidth = maxWidth - model.leftImageH - model.leftContentSpace;
        }
        
        if (ValidStr(model.leftSubTitle)) {
            CGSize leftSubTitleSize = [model.leftSubTitle tt_sizeWithFont:model.leftSubFont];
            maxWidth = maxWidth - leftSubTitleSize.width - 2 - model.leftContentSpace;
        }
        
        CGSize titleSize = [model.leftTitle tt_sizeWithFont:model.leftFont constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:model.lineSpace];
        
        return model.cellHeight + titleSize.height - model.leftFont.lineHeight;
        
    }else if(model.isRightMultiLine && ValidStr(model.rightTitle)){
        CGFloat maxWidth = model.cellWidth - model.leftMargin - model.rightMargin;
         if (model.rightImage) {
             maxWidth = maxWidth - model.rightImageH - model.rightContentSpace;
         }
         
         if (ValidStr(model.rightSubTitle)) {
             CGSize rightSubTitleSize = [model.rightSubTitle tt_sizeWithFont:model.rightSubFont];
             maxWidth = maxWidth - rightSubTitleSize.width - 2 - model.rightContentSpace;
         }
         
         
        
        if (ValidStr(model.leftTitle)) {
            CGSize leftTitleSize = [model.leftTitle tt_sizeWithFont:model.leftFont];
            maxWidth = maxWidth - leftTitleSize.width - 2 - model.leftContentSpace;
        }
         
        if (ValidStr(model.leftSubTitle)) {
            CGSize leftSubTitleSize = [model.leftSubTitle tt_sizeWithFont:model.leftSubFont];
            maxWidth = maxWidth - leftSubTitleSize.width - 2 - model.leftContentSpace;
        }
        
        if (model.leftImage) {
            maxWidth = maxWidth - model.leftImageH - model.leftContentSpace;
        }
        
         CGSize titleSize = [model.rightTitle tt_sizeWithFont:model.rightFont constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:model.lineSpace];
         
         return model.cellHeight + titleSize.height - model.rightFont.lineHeight;
        
    }else{
        return model.cellHeight;
    }
    return cellHeight;
}

@end
