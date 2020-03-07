//
//  ZStudentOrganizationDetailIntroLabelCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroLabelCell.h"

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
    
    [self setActivityData];
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

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(280);
}


- (void)setActivityData {
    [self.activityView removeAllSubviews];
    NSArray *textArr = @[@"满减10", @"收单优惠"];
    
    CGFloat leftX = 0;
    for (int i = 0; i < textArr.count; i++) {
        UIView *label = [self getViewWithText:textArr[i] leftX:leftX];
        [self.activityView addSubview:label];
        leftX = label.right + CGFloatIn750(8);
    }
    
}

//
//- (void)setList:(NSArray<ZStudentDetailLessonTimeSubModel *> *)list {
//    _list = list;
//    [_timeView removeAllSubviews];
//
//    CGFloat width = KScreenWidth - CGFloatIn750(300);
//    CGFloat space = (width - CGFloatIn750(120) * 3)/4;
//    CGFloat leftX = space;
//    CGFloat topY = 0;
//   for (int i = 0; i < list.count; i++) {
//       if (i % 3 == 0) {
//           leftX = space;
//       }
//       if (i != 0 && i % 3 == 0) {
//           topY += CGFloatIn750(50) + CGFloatIn750(42);
//       }
//
//       ZStudentDetailLessonTimeSubModel *model = list[i];
//       UIView *label = [self getViewWithText:model.subTime leftX:leftX topY:topY tag:i];
//       [self.timeView addSubview:label];
//
//       leftX += CGFloatIn750(120) + space;
//   }
//}


- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, tempSize.width+6, CGFloatIn750(30))];
    actLabel.textColor = [UIColor colorOrangeMoment];
    actLabel.layer.masksToBounds = YES;
    actLabel.layer.cornerRadius = 2;
    actLabel.layer.borderColor = [UIColor colorOrangeMoment].CGColor;
    actLabel.layer.borderWidth = 0.5;
    actLabel.text = text;
    actLabel.numberOfLines = 0;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont fontMin]];
    
    
    return actLabel;
}


- (void)setModel:(ZBaseMultiseriateCellModel *)model {
    _model = model;
    self.titleLabel.text = model.leftTitle;
    
    
    self.titleLabel.font = model.leftFont ? model.leftFont:[UIFont systemFontOfSize:kCellTitleFont];
   
    self.titleLabel.textColor = model.leftColor ? adaptAndDarkColor(model.leftColor,model.leftDarkColor):adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    
    self.titleLabel.text = model.leftTitle;
    self.rightImageView.hidden = YES;
    
    if (model.leftTitle && model.leftTitle.length > 0) {
        CGSize leftLabelSize = [SafeStr(model.leftTitle) tt_sizeWithFont:model.leftFont];
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
            
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.titleLabel.mas_right).offset(model.leftContentSpace);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }else{
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
            
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightImageView.mas_left).offset(-model.rightContentSpace);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }else{
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                make.top.equalTo(self.contentView.mas_top).offset((model.singleCellHeight - model.leftFont.lineHeight)/2);
                make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }
    }
    
    [self setActivityData];
}

@end

