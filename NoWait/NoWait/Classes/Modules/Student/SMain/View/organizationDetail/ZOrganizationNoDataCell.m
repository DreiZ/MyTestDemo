//
//  ZOrganizationNoDataCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationNoDataCell.h"

@interface ZOrganizationNoDataCell ()
@property (nonatomic,strong) UIImageView *noDataImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation ZOrganizationNoDataCell

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
    [self.contentView addSubview:self.noDataImageView];
    [self.contentView addSubview:self.nameLabel];
    
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(CGFloatIn750(18));
    }];
}

- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] init];
        _noDataImageView.image = [UIImage imageNamed:@"noLesson"];
        _noDataImageView.layer.masksToBounds = YES;
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _noDataImageView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontSmall]];
    }
    return _nameLabel;
}

- (void)setType:(NSString *)type {
    _type = type;
    
    switch ([type intValue]) {
        case ZNoDataTypeAll:
        {
            _nameLabel.text = @"暂无数据";
            _noDataImageView.image = [UIImage imageNamed:@"noLesson"];
        }
            break;
        case ZNoDataTypeLesson:
        {
            _nameLabel.text = @"暂无课程";
            _noDataImageView.image = [UIImage imageNamed:@"noLesson"];
        }
            break;
        case ZNoDataTypeTeacher:
        {
            _nameLabel.text = @"暂无教师";
            _noDataImageView.image = [UIImage imageNamed:@"noTeacher"];
        }
            break;
        case ZNoDataTypeEva:
        {
            _nameLabel.text = @"暂无评价";
            _noDataImageView.image = [UIImage imageNamed:@"noEva"];
        }
            break;
        case ZNoDataTypeInfo:
        {
            _nameLabel.text = @"暂无介绍";
            _noDataImageView.image = [UIImage imageNamed:@"noTeacherInfo"];
        }
            break;
        case ZNoDataTypePhoto:
        {
            _nameLabel.text = @"暂无相册";
            _noDataImageView.image = [UIImage imageNamed:@"noInfo"];
        }
            break;
            
        default:
            break;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(220);
}
@end
