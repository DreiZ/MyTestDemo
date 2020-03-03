//
//  ZStudentOrganizationLessonMoreCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonMoreCell.h"

@interface ZStudentOrganizationLessonMoreCell ()
@property (nonatomic,strong) UILabel *moreLabel;

@end

@implementation ZStudentOrganizationLessonMoreCell
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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIImageView *moreImageView = [[UIImageView alloc] init];
    moreImageView.image = [UIImage imageNamed:@"mineLessonDown"];
    moreImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:moreImageView];
    [moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moreLabel.mas_right).offset(CGFloatIn750(8));
        make.centerY.equalTo(self.moreLabel.mas_centerY);
    }];
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moreLabel.textColor = [UIColor colorTextGray];
        _moreLabel.text = @"查看更多初学者课程";
        _moreLabel.numberOfLines = 1;
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        [_moreLabel setFont:[UIFont fontSmall]];
    }
    return _moreLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(88);
}

- (void)setMoreTitle:(NSString *)moreTitle {
    _moreTitle = moreTitle;
    self.moreLabel.text = moreTitle;
}
@end
