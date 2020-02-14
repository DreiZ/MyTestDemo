//
//  ZStudentStarStudentInfoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarStudentInfoCell.h"

@interface ZStudentStarStudentInfoCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *cocahLabel;

@end

@implementation ZStudentStarStudentInfoCell
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
    
    UILabel *nameHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    nameHintLabel.text = @"姓名";
    nameHintLabel.numberOfLines = 1;
    nameHintLabel.textAlignment = NSTextAlignmentCenter;
    [nameHintLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(26)]];
    [self addSubview:nameHintLabel];
    
    UILabel *lessonHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lessonHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    lessonHintLabel.text = @"课程";
    lessonHintLabel.numberOfLines = 1;
    lessonHintLabel.textAlignment = NSTextAlignmentCenter;
    [lessonHintLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(26)]];
    [self addSubview:lessonHintLabel];
    
    UILabel *cocahHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    cocahHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    cocahHintLabel.text = @"教练";
    cocahHintLabel.numberOfLines = 1;
    cocahHintLabel.textAlignment = NSTextAlignmentCenter;
    [cocahHintLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(26)]];
    [self addSubview:cocahHintLabel];
    
    [nameHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.mas_left).offset(KScreenWidth/6);
    }];
    
    [lessonHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [cocahHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.mas_right).offset(-KScreenWidth/6);
    }];
    
    
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nameHintLabel.mas_centerX);
        make.top.equalTo(nameHintLabel.mas_bottom).offset(CGFloatIn750(16));
    }];
    
   [self.contentView addSubview:self.lessonLabel];
   [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(lessonHintLabel.mas_centerX);
       make.top.equalTo(lessonHintLabel.mas_bottom).offset(CGFloatIn750(16));
   }];
    
    [self.contentView addSubview:self.cocahLabel];
    [self.cocahLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cocahHintLabel.mas_centerX);
        make.top.equalTo(cocahHintLabel.mas_bottom).offset(CGFloatIn750(16));
    }];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
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
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _lessonLabel.text = @"瑜伽";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentCenter;
        [_lessonLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(36)]];
    }
    return _lessonLabel;
}


- (UILabel *)cocahLabel {
    if (!_cocahLabel) {
        _cocahLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cocahLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _cocahLabel.text = @"王娇";
        _cocahLabel.numberOfLines = 1;
        _cocahLabel.textAlignment = NSTextAlignmentCenter;
        [_cocahLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(36)]];
    }
    return _cocahLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

@end


