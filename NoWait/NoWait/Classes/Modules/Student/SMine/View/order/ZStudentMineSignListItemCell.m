//
//  ZStudentMineSignListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignListItemCell.h"
@interface ZStudentMineSignListItemCell ()
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *lessonHintLabel;

@end

@implementation ZStudentMineSignListItemCell
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.lessonLabel];
    [self.contentView addSubview:self.lessonHintLabel];
    [self.lessonHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(65));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonHintLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.lessonHintLabel.mas_centerY);
    }];
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonLabel.text = @"利萨斯";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _lessonLabel;
}

- (UILabel *)lessonHintLabel {
    if (!_lessonHintLabel) {
        _lessonHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonHintLabel.textColor = [UIColor colorTextGray];
        _lessonHintLabel.text = @"教练：";
        _lessonHintLabel.numberOfLines = 1;
        _lessonHintLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonHintLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _lessonHintLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(36);
}
@end
