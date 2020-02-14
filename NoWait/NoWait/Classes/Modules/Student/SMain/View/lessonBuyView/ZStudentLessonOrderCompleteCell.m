//
//  ZStudentLessonOrderCompleteCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderCompleteCell.h"

@interface ZStudentLessonOrderCompleteCell ()
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIView *bottomLineView;


@property (nonatomic,strong) NSDictionary *data;
@end

@implementation ZStudentLessonOrderCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
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
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"mineLessonRight"];
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
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _leftTitleLabel.text = @"标题";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(30)]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
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
        _bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorBlackBG]);
    }
    return _bottomLineView;
}

- (void)setModel:(ZStudentDetailOrderSubmitListModel *)model {
    _model = model;
    _leftTitleLabel.text = model.leftTitle;
    _rightTitleLabel.text = model.rightTitle;
    
    _leftTitleLabel.font = model.leftFont ? model.leftFont:[UIFont boldSystemFontOfSize:CGFloatIn750(30)];
    _rightTitleLabel.font = model.rightFont ? model.rightFont:[UIFont boldSystemFontOfSize:CGFloatIn750(30)];
    
    _leftTitleLabel.textColor = model.leftColor ? model.leftColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    _rightTitleLabel.textColor = model.rightColor ? model.rightColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    
    self.bottomLineView.hidden = model.isHiddenBottomLine;
    
    if (model.leftImage && model.leftImage.length > 0) {
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
    
    
    if (model.rightImage && model.rightImage.length > 0) {
        self.rightImageView.image = [UIImage imageNamed:model.rightImage];
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        }];
        
        self.rightImageView.hidden = NO;
    }else{
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(20));
        }];
        
        self.rightImageView.hidden = YES;
    }
}

- (void)setBottomLineHidden:(BOOL)isHidden {
    self.bottomLineView.hidden = isHidden;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
}
@end



