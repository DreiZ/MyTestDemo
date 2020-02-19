//
//  ZStudentLessonSectionTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSectionTitleCell.h"

@interface ZStudentLessonSectionTitleCell ()
@property (nonatomic,strong) UILabel *moreLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *moreImageView;

@end

@implementation ZStudentLessonSectionTitleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(24));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.moreImageView];
    [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(24));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreImageView.mas_left).offset(-CGFloatIn750(4));
        make.centerY.equalTo(self.mas_centerY);
    }];
  
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(24));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(24));
        make.height.mas_equalTo(0.5);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _titleLabel;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moreLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _moreLabel.text = @"";
        _moreLabel.numberOfLines = 1;
        _moreLabel.textAlignment = NSTextAlignmentRight;
        [_moreLabel setFont:[UIFont fontSmall]];
    }
    return _moreLabel;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightGrayArrowDark"]: [UIImage imageNamed:@"rightGrayArrow"];
        _moreImageView.layer.masksToBounds = YES;
    }
    return _moreImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80);
}

- (void)setModel:(ZStudentDetailSectionModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    if (model.isShowRight) {
        _moreLabel.text = model.right;
        _moreLabel.hidden = NO;
        _moreImageView.hidden = NO;
    }else{
        _moreLabel.hidden = YES;
        _moreImageView.hidden = YES;
    }
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    _moreImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightGrayArrowDark"] : [UIImage imageNamed:@"rightGrayArrow"];
}
@end

