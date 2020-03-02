//
//  ZMultiseriateContentLeftLineCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMultiseriateContentLeftLineCell.h"
@interface ZMultiseriateContentLeftLineCell ()
@property (nonatomic,strong) UIView *singleLineView; //单行高度表示

@end

@implementation ZMultiseriateContentLeftLineCell

- (void)initMainView {
    [super initMainView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    ;
    
    [self.contentView addSubview:self.singleLineView];
    [self.singleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(kCellNormalHeight);
        make.right.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.singleLineView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-kCellRightMargin);
    }];
    
    [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.singleLineView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(kCellLeftMargin);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset((kCellNormalHeight - kCellTitleFont - 2)/2);
        make.left.equalTo(self.leftImageView.mas_right).offset(kCellContentSpace);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(kCellContentLittleSpace);
        make.top.equalTo(self.contentView.mas_top).offset((kCellNormalHeight - kCellTitleFont - 2)/2);
        make.width.mas_equalTo(KScreenWidth/3);
    }];
}

- (UIView *)singleLineView {
    if (!_singleLineView) {
        _singleLineView = [[UIView alloc] init];
        _singleLineView.layer.masksToBounds = YES;
    }
    return _singleLineView;
}

- (void)setMModel:(ZBaseMultiseriateCellModel *)mModel {
    _mModel = mModel;
    
    self.leftTitleLabel.text = mModel.leftTitle;
    self.rightTitleLabel.text = mModel.rightTitle;
    self.leftTitleLabel.numberOfLines = 1;
    self.rightTitleLabel.numberOfLines = 0;
    self.rightTitleLabel.textAlignment = mModel.textAlignment;
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(mModel.lineLeftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-mModel.lineRightMargin);
    }];
    
    self.leftTitleLabel.font = mModel.leftFont ? mModel.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
    self.rightTitleLabel.font = mModel.rightFont ? mModel.rightFont:[UIFont systemFontOfSize:kCellTitleFont];
    
    self.leftTitleLabel.textColor = mModel.leftColor ? adaptAndDarkColor(mModel.leftColor,mModel.leftDarkColor):adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.rightTitleLabel.textColor = mModel.rightColor ? adaptAndDarkColor(mModel.rightColor,mModel.rightDarkColor) :adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.bottomLineView.hidden = mModel.isHiddenLine;
    
    
    [self.singleLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(mModel.singleCellHeight);
        make.right.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    if (mModel.leftImage && mModel.leftImage.length > 0) {
        //leftImage
        self.leftImageView.image = [UIImage imageNamed:mModel.leftImage];
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
            if (mModel.leftImageWidth > 0.01) {
                make.width.mas_equalTo(mModel.leftImageWidth);
            }
        }];
        
        self.leftImageView.hidden = NO;
        
        if (mModel.leftTitle && mModel.leftTitle.length > 0) {
            //leftImage leftTitle
            CGSize leftLabelSize = [SafeStr(mModel.leftTitle) tt_sizeWithFont:mModel.leftFont];
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.left.equalTo(self.leftImageView.mas_right).offset(mModel.leftContentSpace);
                make.width.mas_equalTo(leftLabelSize.width+2);
            }];
            
            
            if (mModel.rightImage && mModel.rightImage.length > 0) {
                //leftImage leftTitle rightImage
                self.rightImageView.image = [UIImage imageNamed:mModel.rightImage];
                
                [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.singleLineView.mas_centerY);
                    make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
                    if (mModel.rightImageWidth > 0.01) {
                        make.width.mas_equalTo(mModel.rightImageWidth);
                    }
                }];
                self.rightImageView.hidden = NO;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //leftImage leftTitle rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //leftImage leftTitle rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }else{
                //leftImage leftTitle rightImage
                self.rightImageView.hidden = YES;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //leftImage leftTitle no-rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin;
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //leftImage leftTitle no-rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }
        }else{
            //leftImage no-leftTitle
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.left.equalTo(self.leftImageView.mas_right).offset(mModel.leftContentSpace);
                make.width.mas_equalTo(0);
            }];
            
            
            if (mModel.rightImage && mModel.rightImage.length > 0) {
                //leftImage no-leftTitle rightImage
                self.rightImageView.image = [UIImage imageNamed:mModel.rightImage];
                
                [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.singleLineView.mas_centerY);
                    make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
                    if (mModel.rightImageWidth > 0.01) {
                        make.width.mas_equalTo(mModel.rightImageWidth);
                    }
                }];
                self.rightImageView.hidden = NO;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //leftImage no-leftTitle rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftImageView.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //leftImage no-leftTitle rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftImageView.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }else{
                //leftImage no-leftTitle no-rightImage
                self.rightImageView.hidden = YES;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //leftImage no-leftTitle no-rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - mModel.rightMargin;
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftImageView.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                     //leftImage no-leftTitle no-rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftImageView.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }
        }
    }else{
        //no-leftImage
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(-mModel.leftMargin);
            make.width.mas_equalTo(0);
        }];
        
        self.leftImageView.hidden = YES;
        
        if (mModel.leftTitle && mModel.leftTitle.length > 0) {
            //no-leftImage leftTitle
            CGSize leftLabelSize = [SafeStr(mModel.leftTitle) tt_sizeWithFont:mModel.leftFont];
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.left.equalTo(self.singleLineView.mas_left).offset(mModel.leftMargin);
                make.width.mas_equalTo(leftLabelSize.width+2);
            }];
            
            if (mModel.rightImage && mModel.rightImage.length > 0) {
                //no-leftImage leftTitle rightImage
                self.rightImageView.image = [UIImage imageNamed:mModel.rightImage];
                
                [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.singleLineView.mas_centerY);
                    make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
                    if (mModel.rightImageWidth > 0.01) {
                        make.width.mas_equalTo(mModel.rightImageWidth);
                    }
                }];
                self.rightImageView.hidden = NO;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //no-leftImage leftTitle rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //no-leftImage leftTitle rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }else{
                //no-leftImage leftTitle no-rightImage
                self.rightImageView.hidden = YES;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //no-leftImage no-leftTitle no-rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin;
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //no-leftImage leftTitle no-rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftTitleLabel.mas_right).offset(mModel.rightContentSpace);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }
        }else{
            //no-leftImage no-leftTitle
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.left.equalTo(self.singleLineView.mas_left).offset(mModel.leftMargin);
                make.width.mas_equalTo(0);
            }];
            
            
            if (mModel.rightImage && mModel.rightImage.length > 0) {
                //no-leftImage no-leftTitle rightImage
                self.rightImageView.image = [UIImage imageNamed:mModel.rightImage];
                
                [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.singleLineView.mas_centerY);
                    make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
                    if (mModel.rightImageWidth > 0.01) {
                        make.width.mas_equalTo(mModel.rightImageWidth);
                    }
                }];
                self.rightImageView.hidden = NO;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //no-leftImage no-leftTitle rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin  - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //no-leftImage no-leftTitle rightImage no-rightImage
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }else{
                //no-leftImage no-leftTitle rightImage
                self.rightImageView.hidden = YES;
                
                if (mModel.rightTitle && mModel.rightTitle.length > 0) {
                    //no-leftImage no-leftTitle rightImage rightTitle
                    CGFloat rightMaxWidth = mModel.cellWidth - mModel.leftMargin - mModel.rightMargin;
                    
                    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                        make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.rightFont.lineHeight)/2);
                        make.width.mas_equalTo(rightLabelSize.width+2);
                    }];

                    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.rightTitleLabel];
                }else{
                    //no-leftImage no-leftTitle rightImage no-rightTitle
                    [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                        make.centerY.equalTo(self.contentView.mas_centerY);
                        make.width.mas_equalTo(0);
                    }];
                }
            }
        }
    }
}


+(CGFloat)z_getCellHeight:(id)sender {
    ZBaseMultiseriateCellModel *mModel = sender;
    if (!mModel) {
        return kCellNormalHeight;
    }
    
    if (mModel.rightTitle || mModel.rightTitle.length > 0) {
        CGFloat rightMaxWidth = 0;
        if (mModel.leftImage && mModel.leftImage.length > 0) {
            if (mModel.leftTitle && mModel.leftTitle.length > 0) {
                CGSize leftLabelSize = [SafeStr(mModel.leftTitle) tt_sizeWithFont:mModel.leftFont];
                
                if (mModel.rightImage && mModel.rightImage.length > 0) {
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                }else{
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin;
                }
            }else{
                if (mModel.rightImage && mModel.rightImage.length > 0) {
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                }else{
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - ((mModel.leftImageWidth > 0.01) ? mModel.leftImageWidth : 0) - mModel.leftContentSpace - mModel.rightMargin;
                }
            }
        }else{
            if (mModel.leftTitle && mModel.leftTitle.length > 0) {
                CGSize leftLabelSize = [SafeStr(mModel.leftTitle) tt_sizeWithFont:mModel.leftFont];
                if (mModel.rightImage && mModel.rightImage.length > 0) {
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                }else{
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - (leftLabelSize.width + 2) - mModel.leftContentSpace - mModel.rightMargin;
                }
            }else{
                if (mModel.rightImage && mModel.rightImage.length > 0) {
                    //no-leftImage no-leftTitle rightImage
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin  - mModel.rightMargin - mModel.rightContentSpace - ((mModel.rightImageWidth > 0.01) ? mModel.rightImageWidth : 0);
                }else{
                    rightMaxWidth = mModel.cellWidth - mModel.leftMargin - mModel.rightMargin;
                }
            }
        }
        
        CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont constrainedToSize:CGSizeMake(rightMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
        
        return rightLabelSize.height + mModel.singleCellHeight - mModel.rightFont.lineHeight;
    }else{
        return mModel.singleCellHeight;
    }
}
@end

