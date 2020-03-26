//
//  ZOrganizationEvaListUserInfoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListUserInfoCell.h"
#import "CWStarRateView.h"

@interface ZOrganizationEvaListUserInfoCell ()
@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZOrganizationEvaListUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.crView];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(450));
    }];
    
   [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
       make.centerY.equalTo(self.contentView.mas_centerY);
   }];

    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(16));
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(10));
        make.width.offset(CGFloatIn750(110.));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


#pragma mark -Getter

-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        ViewRadius(_userImageView, CGFloatIn750(20));
    }
    return _userImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontMin]];
    }
    return _nameLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont fontMin]];
    }
    return _timeLabel;
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.stores_courses_image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _timeLabel.text = [model.create_at timeStringWithFormatter:@"yyyy-MM-dd"];
    _nameLabel.text = model.stores_name;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(40);
}
@end


