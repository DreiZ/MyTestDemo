//
//  ZStudentStarCoachInfoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarCoachInfoCell.h"

@interface ZStudentStarCoachInfoCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *cocahLabel;

@end

@implementation ZStudentStarCoachInfoCell
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
    self.contentView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
    }];
    
    UIView *lessonBackView = [[UIView alloc] init];
    lessonBackView.layer.masksToBounds = YES;
    lessonBackView.layer.cornerRadius = CGFloatIn750(27);
    lessonBackView.layer.borderColor = KFont6Color.CGColor;
    lessonBackView.layer.borderWidth = 1;
    [self.contentView addSubview:lessonBackView];
    
    
   [self.contentView addSubview:self.lessonLabel];
   [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.mas_centerX);
       make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(18));
       make.width.mas_lessThanOrEqualTo(CGFloatIn750(KScreenWidth - CGFloatIn750(100)));
   }];
    
    [lessonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(54));
        make.centerY.equalTo(self.lessonLabel.mas_centerY);
        make.left.equalTo(self.lessonLabel.mas_left).offset(-CGFloatIn750(26));
        make.right.equalTo(self.lessonLabel.mas_right).offset(CGFloatIn750(26));
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _nameLabel.text = @"段世昌";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(36)]];
    }
    return _nameLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _lessonLabel.text = @"擅长：瑜伽、蛙泳、蝶泳";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentCenter;
        [_lessonLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _lessonLabel;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

@end



