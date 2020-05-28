//
//  ZTeacherMineEntryStoresCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineEntryStoresCell.h"
@interface ZTeacherMineEntryStoresCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *organizationImageView;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;
@end

@implementation ZTeacherMineEntryStoresCell
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
    [super setupView];
    
    [self.contentView addSubview:self.organizationImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lessonLabel];
    
    [self.organizationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(120));
        make.height.mas_equalTo(CGFloatIn750(74));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizationImageView.mas_top);
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(6));
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.organizationImageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontSmall]];
    }
    return _lessonLabel;
}

- (UIImageView *)organizationImageView {
    if (!_organizationImageView) {
        _organizationImageView = [[UIImageView alloc] init];
        _organizationImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_organizationImageView, CGFloatIn750(16));
    }
    return _organizationImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image =  [UIImage imageNamed:@"rightBlackArrowN"];
        _arrowImageView.layer.masksToBounds = YES;
    }
    return _arrowImageView;
}

- (void)setModel:(ZOriganizationDetailModel *)model {
    _model = model;
    _lessonLabel.text = [NSString stringWithFormat:@"%@个课程",model.stores_courses_count];
    _nameLabel.text = SafeStr(model.stores_name);
    [ _organizationImageView tt_setImageWithURL:[NSURL URLWithString:model.stores_image] placeholderImage:[UIImage imageNamed:@"default_image32"]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80);
}
@end





