//
//  ZStudentOrganizationPersonnelMoreCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationPersonnelMoreCell.h"

@interface ZStudentOrganizationPersonnelMoreCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) UIImageView *moreImageView;

@end

@implementation ZStudentOrganizationPersonnelMoreCell
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
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(240));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIView *)moreView {
    if (!_moreView) {
        _moreView = [[UIView alloc] init];
        
        [_moreView addSubview:self.moreImageView];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreView.mas_right).offset(-CGFloatIn750(30));
            make.centerY.equalTo(self.moreView.mas_centerY);
        }];
        
        UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        moreLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        moreLabel.text = @"更多";
        moreLabel.textAlignment = NSTextAlignmentRight;
        [moreLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
        [_moreView addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreImageView.mas_left).offset(-CGFloatIn750(6));
            make.centerY.equalTo(self.moreView.mas_centerY);
        }];
    }
    return _moreView;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"]: [UIImage imageNamed:@"rightBlackArrowN"];
        _moreImageView.layer.masksToBounds = YES;
    }
    return _moreImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"明星教练";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(32)]];
    }
    return _titleLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(88);
}

- (void)setModel:(ZStudentDetailOrderSubmitListModel *)model {
    _model = model;
    
    _titleLabel.text = model.leftTitle;
}
#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    _moreImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] : [UIImage imageNamed:@"rightBlackArrowN"];
}
@end
