//
//  ZMultiseriateLineCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMultiseriateLineCell.h"
@interface ZMultiseriateLineCell ()
@property (nonatomic,strong) UIView *singleLineView; //单行高度表示

@end

@implementation ZMultiseriateLineCell

- (void)initMainView {
    [super initMainView];
    
    UIView *singlineView = [[UIView alloc] init];
    self.singleLineView = singlineView;
    
    [self.contentView addSubview:singlineView];
    [singlineView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.right.equalTo(self.rightImageView.mas_left).offset(-kCellContentLittleSpace);
        make.top.equalTo(self.contentView.mas_top).offset((kCellNormalHeight - kCellTitleFont - 2)/2);
        make.width.mas_equalTo(KScreenWidth/3);
    }];
}

- (void)setMModel:(ZBaseMultiseriateCellModel *)mModel {
    _mModel = mModel;
    
    
    self.leftTitleLabel.text = mModel.leftTitle;
    self.leftTitleLabel.numberOfLines = 0;
    self.rightTitleLabel.text = mModel.rightTitle;
    
    self.leftTitleLabel.font = mModel.leftFont ? mModel.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
    self.rightTitleLabel.font = mModel.rightFont ? mModel.rightFont:[UIFont systemFontOfSize:kCellTitleFont];
    
    self.leftTitleLabel.textColor = mModel.leftColor ? mModel.leftColor:KBlackColor;
    self.rightTitleLabel.textColor = mModel.rightColor ? mModel.rightColor:KBlackColor;
    self.bottomLineView.hidden = mModel.isHiddenLine;
    [ZPublicTool setLineSpacing:mModel.lineSpace label:self.leftTitleLabel];
    
    [self.singleLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(mModel.singleCellHeight);
        make.right.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    if (mModel.leftImage && mModel.leftImage.length > 0) {
        self.leftImageView.image = [UIImage imageNamed:mModel.leftImage];
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(mModel.rightMargin);
            if (mModel.leftImageWidth > 0.01) {
                make.width.mas_equalTo(mModel.leftImageWidth);
            }
        }];
        self.leftImageView.hidden = NO;
    }else{
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(-mModel.leftMargin);
            make.width.mas_equalTo(0);
        }];
        self.leftImageView.hidden = YES;
    }
    
    CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont];
    
    if (mModel.rightImage && mModel.rightImage.length > 0) {
        self.rightImageView.image = [UIImage imageNamed:mModel.rightImage];
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
            if (mModel.rightImageWidth > 0.01) {
                make.width.mas_equalTo(mModel.rightImageWidth);
            }
        }];
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightImageView.mas_left).offset(-mModel.rightContentSpace);
            make.centerY.equalTo(self.rightImageView.mas_centerY);
            make.width.mas_equalTo(rightLabelSize.width);
        }];
        
        self.rightImageView.hidden = NO;
    }else{
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(mModel.rightMargin);
        }];
        
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-mModel.rightMargin);
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.width.mas_equalTo(rightLabelSize.width);
        }];
        
        self.rightImageView.hidden = YES;
    }
    
    if (mModel.rightTitle && mModel.rightTitle.length > 0) {
        if (mModel.leftImage) {
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.leftFont.lineHeight - 2)/2);
                make.left.equalTo(self.leftImageView.mas_right).offset(mModel.leftContentSpace);
                make.right.equalTo(self.rightTitleLabel.mas_left).offset(-mModel.rightContentSpace);
            }];
        }else{
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.leftFont.lineHeight - 2)/2);
                make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                make.right.equalTo(self.rightTitleLabel.mas_left).offset(-mModel.rightContentSpace);
            }];
        }
    }else{
        if (mModel.leftImage) {
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.leftFont.lineHeight - 2)/2);
                make.left.equalTo(self.leftImageView.mas_right).offset(mModel.leftContentSpace);
                make.right.equalTo(self.rightTitleLabel.mas_left).offset(0);
            }];
        }else{
            [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset((mModel.singleCellHeight - mModel.leftFont.lineHeight - 2)/2);
                make.left.equalTo(self.contentView.mas_left).offset(mModel.leftMargin);
                make.right.equalTo(self.rightTitleLabel.mas_left).offset(0);
            }];
        }
    }
    
    
    self.bottomLineView.hidden = mModel.isHiddenLine;
}


+(CGFloat)z_getCellHeight:(id)sender {
    ZBaseMultiseriateCellModel *mModel = sender;
    
    CGFloat otherMaxWidth = mModel.leftMargin + mModel.rightMargin;
    if (mModel.leftImage && mModel.leftImage.length > 0) {
        otherMaxWidth += mModel.leftImageWidth + mModel.leftContentSpace;
    }
    
    if (mModel.rightImage && mModel.rightImage.length > 0) {
        otherMaxWidth += mModel.rightImageWidth + mModel.rightContentSpace;
    }
    
    if (mModel.rightTitle && mModel.rightTitle.length > 0) {
        CGSize rightLabelSize = [SafeStr(mModel.rightTitle) tt_sizeWithFont:mModel.rightFont];
        otherMaxWidth += rightLabelSize.width + mModel.rightContentSpace;
    }
    
    CGSize leftLabelSize = [SafeStr(mModel.leftTitle) tt_sizeWithFont:mModel.leftFont constrainedToSize:CGSizeMake(mModel.cellWidth - otherMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:mModel.lineSpace];
    
    return leftLabelSize.height + mModel.cellHeight - mModel.leftFont.lineHeight;
}
@end
