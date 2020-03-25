//
//  ZStudentStarInfoCoachMoreEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarInfoCoachMoreEvaCell.h"

@interface ZStudentStarInfoCoachMoreEvaCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation ZStudentStarInfoCoachMoreEvaCell
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
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(125));
        make.centerY.equalTo(self.mas_centerY);
    }];
  
    [self.contentView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(10));
    }];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _nameLabel.text = @"查看全部评价";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(26)]];
    }
    return _nameLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"]: [UIImage imageNamed:@"rightBlackArrowN"];
        _arrowImageView.layer.masksToBounds = YES;
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _arrowImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}


- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = title;
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    _arrowImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] : [UIImage imageNamed:@"rightBlackArrowN"];
}
@end


