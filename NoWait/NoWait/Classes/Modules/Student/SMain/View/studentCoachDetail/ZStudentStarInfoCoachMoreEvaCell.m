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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
        _nameLabel.textColor = [UIColor  colorMain];
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
        _arrowImageView.image = [UIImage imageNamed:@"rightBlackArrow"];
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
@end


