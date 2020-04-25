//
//  ZStudentOrganizationDetailIntroLabelCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroLabelCell.h"

#define kLabelHeight CGFloatIn750(36)
#define kLabelSpace CGFloatIn750(20)
#define kLabelAddWidth CGFloatIn750(12)
#define kLabelSpaceY CGFloatIn750(20)

@interface ZStudentOrganizationDetailIntroLabelCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) UIImageView *rightImageView;

@property (nonatomic,strong) UIView *singleLineView; //单行高度表示

@end

@implementation ZStudentOrganizationDetailIntroLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.singleLineView];
    [self.singleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(kCellNormalHeight);
        make.right.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.singleLineView.mas_centerY);
    }];
    
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.singleLineView.mas_centerY);
    }];
    
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_top);
        make.right.equalTo(self.rightImageView.mas_left).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontMax1Title]];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _titleLabel;
}


- (UIView *)singleLineView {
    if (!_singleLineView) {
        _singleLineView = [[UIView alloc] init];
        _singleLineView.layer.masksToBounds = YES;
    }
    return _singleLineView;
}


- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}


+ (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr font:(UIFont *)leftFont {
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = 0;
    CGFloat topY = (leftFont.lineHeight - [UIFont fontMin].lineHeight)/2.0f;

    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = 0;
       }
           
       leftX = leftX + tempSize.width+kLabelAddWidth + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}

+(CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZBaseMultiseriateCellModel class]]) {
        ZBaseMultiseriateCellModel *model = (ZBaseMultiseriateCellModel *)sender;
        NSArray *textArr = model.data;
         if (!textArr || textArr.count == 0) {
             textArr = @[];
             return model.cellHeight;
         }
        CGFloat cellHeight = model.singleCellHeight - model.leftFont.lineHeight;
         
         if (model.leftTitle && model.leftTitle.length > 0) {
             CGSize leftLabelSize = [SafeStr(model.leftTitle) tt_sizeWithFont:model.leftFont];
             if (textArr && textArr.count > 0) {
                 if (leftLabelSize.width > model.cellWidth - CGFloatIn750(60) - CGFloatIn750(180)) {
                     leftLabelSize.width = model.cellWidth - CGFloatIn750(60) - CGFloatIn750(180);
                 }
             }
             
             if (model.rightImage && model.rightImage.length > 0) {
                 CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - (leftLabelSize.width + 2) - model.leftContentSpace - model.rightMargin - model.rightContentSpace - ((model.rightImageWidth > 0.01) ? model.rightImageWidth : 0);
                 
                 CGFloat acHeight = [ZStudentOrganizationDetailIntroLabelCell setActivityData:rightMaxWidth textArr:textArr font:model.leftFont];
                 cellHeight += acHeight;
             }else{
                CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - (leftLabelSize.width + 2) - model.leftContentSpace - model.rightMargin - model.rightContentSpace;
                CGFloat acHeight = [ZStudentOrganizationDetailIntroLabelCell setActivityData:rightMaxWidth textArr:textArr font:model.leftFont];
                cellHeight += acHeight;
             }
         }else{
             if (model.rightImage && model.rightImage.length > 0) {
                 CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - model.rightMargin - model.rightContentSpace - ((model.rightImageWidth > 0.01) ? model.rightImageWidth : 0);
                 
                 CGFloat acHeight = [ZStudentOrganizationDetailIntroLabelCell setActivityData:rightMaxWidth textArr:textArr font:model.leftFont];
                 cellHeight += acHeight;
             }else{
                 CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - model.rightMargin ;
                 CGFloat acHeight = [ZStudentOrganizationDetailIntroLabelCell setActivityData:rightMaxWidth textArr:textArr font:model.leftFont];
                 cellHeight += acHeight;
             }
         }
        return cellHeight;
    }
    return CGFloatIn750(0);
}


- (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    [self.activityView removeAllSubviews];
    
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = 0;
    CGFloat topY = (self.model.leftFont.lineHeight - [UIFont fontMin].lineHeight)/2.0 - CGFloatIn750(4);

    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = 0;
       }
           
       UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+kLabelAddWidth, kLabelHeight)];
       actLabel.textColor = self.model.rightColor;
        actLabel.backgroundColor = self.model.rightDarkColor;
       actLabel.text = adeptArr[i];
       actLabel.numberOfLines = 1;
        actLabel.layer.masksToBounds = YES;
        actLabel.layer.cornerRadius = CGFloatIn750(4);
       actLabel.textAlignment = NSTextAlignmentCenter;
       [actLabel setFont:[UIFont fontMin]];
       [self.activityView addSubview:actLabel];
       leftX = actLabel.right + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}


- (void)setModel:(ZBaseMultiseriateCellModel *)model {
    _model = model;
    self.titleLabel.text = model.leftTitle;
    
    NSArray *textArr = model.data;
    if (!textArr || textArr.count == 0) {
        textArr = @[];
        self.activityView.hidden = YES;
    }else{
        self.activityView.hidden = NO;
    }
    
    self.titleLabel.font = model.leftFont ? model.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
   
    self.titleLabel.textColor = model.leftColor ? adaptAndDarkColor(model.leftColor,model.leftDarkColor):adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    
    self.titleLabel.text = model.leftTitle;
    self.rightImageView.hidden = YES;
    
    
    [self.singleLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(model.singleCellHeight);
        make.right.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    if (model.leftTitle && model.leftTitle.length > 0) {
        CGSize leftLabelSize = [SafeStr(model.leftTitle) tt_sizeWithFont:model.leftFont];
        if (textArr && textArr.count > 0) {
            if (leftLabelSize.width > model.cellWidth - CGFloatIn750(60) - CGFloatIn750(180)) {
                leftLabelSize.width = model.cellWidth - CGFloatIn750(60) - CGFloatIn750(180);
            }
        }
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.singleLineView.mas_centerY);
            make.left.equalTo(self.singleLineView.mas_left).offset(model.leftMargin);
            make.width.mas_equalTo(leftLabelSize.width+2);
        }];
        
        if (model.rightImage && model.rightImage.length > 0) {
            self.rightImageView.image = [UIImage imageNamed:model.rightImage];
            
            [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                if (model.rightImageWidth > 0.01) {
                    make.width.mas_equalTo(model.rightImageWidth);
                }
            }];
            self.rightImageView.hidden = NO;
            
            CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - (leftLabelSize.width + 2) - model.leftContentSpace - model.rightMargin - model.rightContentSpace - ((model.rightImageWidth > 0.01) ? model.rightImageWidth : 0);
            
            [self setActivityData:rightMaxWidth textArr:textArr];
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.titleLabel.mas_right).offset(model.leftContentSpace);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }else{
            CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - (leftLabelSize.width + 2) - model.leftContentSpace - model.rightMargin - model.rightContentSpace;
            [self setActivityData:rightMaxWidth textArr:textArr];
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.titleLabel.mas_right).offset(model.leftContentSpace);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
            
        }
    }else{
        if (model.rightImage && model.rightImage.length > 0) {
            self.rightImageView.image = [UIImage imageNamed:model.rightImage];
            
            [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.singleLineView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                if (model.rightImageWidth > 0.01) {
                    make.width.mas_equalTo(model.rightImageWidth);
                }
            }];
            self.rightImageView.hidden = NO;
            
            CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - model.rightMargin - model.rightContentSpace - ((model.rightImageWidth > 0.01) ? model.rightImageWidth : 0);
            
            [self setActivityData:rightMaxWidth textArr:textArr];
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }else{
            CGFloat rightMaxWidth = model.cellWidth - model.leftMargin - model.rightMargin ;
            [self setActivityData:rightMaxWidth textArr:textArr];
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }
    }
    
}

@end

